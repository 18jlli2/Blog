<template>
  <div>
    <el-table :data="blogsData" style="width:100%">
      <el-table-column label="文章列表">
        <template slot-scope="scope"><!--使用scope访问每篇文章属性-->
          <el-card class="box-card">
            <!--标题部分 shareStatement判断是否为草稿-->
            <div style="font-size:18px;">
              <el-button size="mini" v-if="!scope.row.shareStatement" 
              type="info" icon="el-icon-edit" circle></el-button>
              {{scope.row.title}}
            </div>

            <!--细节部分-->
            <div style="margin-top:10px">
              <el-tag size="small" style="margin-right:10px"
              v-if="scope.row.isDelete" type="danger">已删除</el-tag>
              <el-tag size="small" style="margin-right:10px" 
              v-if="!scope.row.shareStatement" type="warning">草稿</el-tag>
              <el-tag size="small" style="margin-right:10px"
              v-if="scope.row.shareStatement">{{scope.row.flag}}</el-tag>
              <el-tag size="small" style="margin-right:10px"
              v-if="scope.row.shareStatement" type="info">
              {{scope.row.published == '0' ? '私密' : '公开'}}</el-tag>

              <el-tag size="small" style="margin-right:30px">{{scope.row.typeName}}</el-tag>

              <i style="margin-right:20px" class="el-icon-view">{{scope.row.views}}</i>
              <i style="margin-right:20px" class="el-icon-chat-square">{{scope.row.commentCount}}</i>
              <i style="margin-right:20px" class="el-icon-date">{{scope.row.createTime}}</i>

              <!--功能按钮-->

              <!--逻辑删除-->
              <el-button style="float:right" size="mini" type="danger" v-if="!scope.row.isDelete" @click="logicDel(scope.row.id,scope.$index)">删除</el-button>
              
              <!--编辑文章-->
              <router-link :to=" '/admin/EditCon/' + scope.row.id " v-if="!scope.row.isDelete">
                <el-button style="float:right;margin-right:10px" type="primary  " size="mini">编辑</el-button>
              </router-link>

              <!--彻底删除-->
              <el-button v-if="scope.row.isDelete" style="float:right" type="danger" size="mini" @click="completelyDel(scope.row.id,scope.$index)">彻底删除</el-button>

              <!--还原-->
              <el-button v-if="scope.row.isDelete" style="float:right;margin-right:10px;" type="info" size="mini" @click="recoveryBlog(scope.row.id,scope.$index)">还原</el-button>
            </div>
          </el-card>
        </template>
      </el-table-column> 
    </el-table>
    <!--分页控制-->
    <div style="margin-top:20px;">
      <el-pagination
        background
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="currentPage"
        :page-sizes="pageSizes"
        :page-size="pageSize"
        layout="total,sizes,prev,pager,next,jumper"
        :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script>
export default {
  name: 'BlogListCom',
  data() {
    return {
      blogsData:[],//文章数据
      currentPage:1,//当前页
      total:0,//文章总数
      pageSize:10,//每页显示多少篇文章
      pageSizes:[10,20,30],//选择每页显示数量
      t2index:0,//选项卡index 判断是哪个栏目
    }
  },
  props:["tindex"],//传入当前页数
  //生命周期 - 创建完成（访问当前this实例）
  created() {

  },
  mounted() {
    this.initIndex();
    this.initBlogs();
  },
  methods:{
    initIndex(){
      this.t2index = this.tindex;//保存当前栏目编号
    },
    initBlogs(){//初始化博客数据
      //请求的通用参数
      let baseurl = '/blog/getByPage?current=' + this.currentPage + '&size=' + this.pageSize;
      //根据栏目编号拼接不同的参数
      switch (this.t2index/1) {
        case 0://全部
          break;
        case 1://原创
          baseurl += " &flag=原创 &share_statement=1 &is_delete=0"
          break;
        case 2://转载
          baseurl += " &flag=转载 &share_statement=1  &is_delete=0"
          break;
        case 3://草稿
          baseurl += " &share_statement=0  &is_delete=0"
          break;
        case 4://公开
          baseurl += " &published=1 &share_statement=1  &is_delete=0"
          break;
        case 5://私密
          baseurl += " &published=0 &share_statement=1  &is_delete=0"
          break;
        case 6://回收站
          baseurl += "  &is_delete=1"
          break;
        default:
          break;
      }
      let that = this;
      this.getRequest(baseurl).then(res =>{
        if(res){
          console.log(res.obj.records)
          that.blogsData = res.obj.records;//得到查询到的数据
          // that.blogsData.forEach((val,idx)=>{//获取type 待修复bug
          //   if(val.typeId != null){
          //     that.getRequest('/type/getTypeById?id=' + val.typeId).then(typeData=>{
          //       if(typeData && typeData.obj != null){
          //         val.tblogTags = typeData.obj.name
          //       }
          //     })
          //   }
          // })
          that.total = res.obj.total;//得到总记录数
        }
      })
    },
    handleCurrentChange(val){//当前页码变化
      this.currentPage = val;
      this.initBlogs();//发送请求
    },
    handleSizeChange(val){//每页显示数量变化
      this.pageSize = val;
      this.initBlogs();//发送
    },
    logicDel(id,idx){//逻辑删除 首次删除进入回收站
      let that = this;
      this.$confirm('将文章扔进回收站?','提示',{
        confirmButtonText:'确定',
        cancelBUttonText:'取消',
        type:'warning'
      }).then(_=>{
        that.deleteRequest('/blog/logicDeleteBlog?id=' + id).then(res=>{
          if(res){
            that.blogsData[idx].isDelete = 1
            that.$message.success('操作成功')
          }
        })
      }).catch(_=>{
        //取消删除回调函数
      })
    },
    completelyDel(id,idx){//彻底删除
      let that = this
      this.$confirm('此操作将彻底删除文章，是否继续','提示',{
        confirmButtonText:'确定',
        cancelButtonText:'取消',
        type:'warning'
      }).then(_=>{
        this.deleteRequest('/blog/deleteBlog?id=' + id).then(res=>{
          if(res){
            that.blogsData.splice(idx,1)
            that.$message.success('删除成功')
          }
        })
      }).catch(_=>{
        //取消删除回调函数
      })
    },
    recoveryBlog(id,idx){//从回收站恢复
      let that = this
      this.$confirm('此操作将还原博客，是否继续?','提示',{
        confirmButtonText:'确定',
        cancelButtonText:'取消',
        type:'warning'
      }).then(_=>{
        that.getRequest('/blog/recoveryBlog?id=' + id).then(res=>{
          if(res){
            that.blogsData[idx].isDelete = 0
            that.$message.success('还原成功!')
          }
        })
      }).catch(_=>{
        //取消还原回调函数
      })
    },
  }
}
</script>
<style scoped>

</style>