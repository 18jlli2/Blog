<template>
  <div class="m_container">
    <!-- 写博客界面 -->
    <div class="m_content">
      <el-form ref="editForm" status-icon :model="editForm" :rules="rules1" label-width="80px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="editForm.title"></el-input>
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input v-model="editForm.description"></el-input>
        </el-form-item>
        <el-form-item label="首页图片" prop="first_picture">
          <el-input v-model="editForm.first_picture"></el-input>
        </el-form-item>
        <el-form-item label="文章标签">
          <el-tag :key="tag" v-for="(tag,idx) in editForm.tags" 
          closable @close="handleTagClose(idx)"
          :disable-transitions="false">
            {{tag}}
          </el-tag>
          <el-input 
            class="input-new-tag" v-if="inputVisible" v-model="inputValue" 
            ref="saveTagInput" size="small" 
            @keyup.enter.native="handleInputConfirm"
            @blur="handleInputConfirm"
          >
          </el-input>
          <el-button v-else 
            class="button-new-tag" 
            style="margin-left:10px;" 
            size="small"
            @click="showInput"
          >
            + New Tag
          </el-button>
        </el-form-item>
        <el-form-item label="分类专栏" prop="type_id"> 
          <el-select v-model="editForm.type_id" placeholder="请选择分类专栏"> 
            <el-option v-for="(item,idx) in getalltype" :key="idx" :label="item.name" :value="item.id + ''"></el-option>
          </el-select>
          <el-button type="primary" size="small" @click="dialog2 = true" style="margin-left:10px">新建分类专栏</el-button>
        </el-form-item>
        <el-form-item label="文章类型" prop="flag">
          <el-select v-model="editForm.flag" placeholder="请选择文章类型，默认为原创">
            <el-option label="原创" value="原创"></el-option>
            <el-option label="转载" value="转载"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="发布形式" prop="published">
          <el-select v-model="editForm.published" placeholder="请选择发布形式，默认为公开">
            <el-option label="公开" value=1></el-option>
            <el-option label="私密" value=0></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <mavon-editor v-model="editForm.content"/>
        </el-form-item>
        <el-form-item style="margin:auto"><!--功能按钮-->
          <el-button type="primary" @click="submitBlog('editForm')">保存更改</el-button>
          <router-link to="/admin/allblogs">
            <el-button type="info" style="margin-left: 10px;">返回</el-button>
          </router-link>
        </el-form-item>
      </el-form>
    </div>

    <!--新建专栏对话框-->
    <el-dialog 
      title="新建分类专栏"
      :visible.sync="dialog2"
      width="30%"
    >
      <el-form status-icon :model="type" ref="type" label-width="120px" :rules="rules2">
        <el-form-item label="分类专栏名" prop="name">
          <el-input v-model="type.name" placeholder="请输入新建分类专栏名"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialog2 = false" type="info">取消</el-button>
        <el-button @click="submitNewType('type')" type="primary">确定</el-button>
      </span>
    </el-dialog>  
  </div>
</template>

<script>
export default {
  name: 'EditCon',
  data() {
    return {
      editForm:{
        id:null,
        title:"",
        description:"",
        first_picture:"",
        content:"",
        type_id:'',
        type_name:'',
        flag:'',
        published:null,
        tags:[],
      },
      rules1: {  //文章内容校验
        title: [
          {required: true, message: '请输入标题', trigger: 'blur'},
          {min: 3, max: 100, message: '长度在 3 到 100 个字符', trigger: 'blur'}
        ],
        description: [
          {required: true, message: '请输入摘要', trigger: 'blur'}
        ],
        first_picture: [
          {required: true, message: '请输入图片地址', trigger: 'blur'}
        ],
        content: [
          {required: true, message: '请输入文章内容', trigger: 'blur'}
        ],
        type_id: [
          {required: true, message: '分类专栏不能为空', trigger: 'blur'}
        ],
        flag: [
          {required: true, message: '文章类型不能为空', trigger: 'blur'}
        ],
        published: [
          {required: true, message: '发布形式不能为空', trigger: 'blur'}
        ],
      }, 
      rules2: {//新建分类专栏校验
        name:[
          {required:true, message:"分类专栏名不能为空", trigger:"blur"}
        ],
      },
      type:{//新建分类专栏
        name:''
      },
      getalltype:[],//用于保存所有分类专栏
      formLabelWidth:"120px",
      inputVisible:false,
      inputValue:'',
      dialog2:false,

    }
  },
  props:['id'],
  //生命周期 - 创建完成（访问当前this实例）
  created() {

  },
  mounted() {
    this.initType();
    this.initBlog();
  },
  methods:{
    showInput(){//点击addtag按钮后显示input栏
      this.inputVisible = true;
      this.$nextTick(_=>{
        this.$refs.saveTagInput.$refs.input.focus();
      })
    },
    handleInputConfirm(){//处理添加标签
      this.inputValue.length == 0 ? 0 : this.editForm.tags.push(this.inputValue);
      this.inputVisible = false;//隐藏输入框
      this.inputValue = "";
    },
    handleTagClose(idx){//处理删除标签事件
      this.editForm.tags.splice(idx,1);
    },
    initType(){//获取所有分类
      let that = this;
      this.getRequest('/type/getAllType').then(res=>{
        that.getalltype = res.obj
      })
    },
    submitNewType(type){//确定新建分类专栏触发
      let that = this 
      this.$refs[type].validate(valid=>{
        if(valid){
          that.addNewType();//向后台发送请求
        }else{
          that.$message({
            message:"请填写必要字段!",
            type:'warning'
          })
        }
      })
    },
    addNewType(){//新建分类
      let that = this;
      this.postRequest('/type/saveType',this.type).then(res=>{
        if(res){
          that.type.name = ''
          that.initType()
          that.dialog2 = false;//隐藏新建分类对话框
        }
      })
    },
    initBlog(){//初始化博客内容
      let that = this;
      this.getRequest('/blog/getByBlogId?id=' + this.id).then(res=>{
        if(res && res.obj){
          that.editForm = res.obj
          console.log(12)
          console.log(res.obj)
          that.editForm.published = res.obj.published == 0 ? '私密' : '公开'
          that.editForm.first_picture = res.obj.firstPicture
          that.editForm.type_id = res.obj.typeId
          that.editForm.type_name = res.obj.typeName
          let ttags = res.obj.tblogTags
          ttags.forEach((val,idx)=>{
            ttags[idx] = val.ttag.name + ''
          })
          that.editForm.tags = ttags
        } 
      })
    },
    submitBlog(editForm){//最终提交博客
      let that = this;
      this.$refs[editForm].validate(valid=>{
        if(valid){
          that.postRequest('/blog/saveBT',that.editForm).then(res=>{
            if(res){
              that.$router.push('/admin/home/AllCon')
              that.$message({
                message:"发布成功!",
                type:"success"
              })
            }
          })
        }else{
          this.$message({
            message:"请填写必要字段!",
            type:"warning"
          })
        }
      })
    },
  }
  }
</script>
<style scoped>
.m_container{
  margin-top:20px;
}
.el-tag + .el-tag{
  margin-left:10px;
}
.button-new-tag{
  margin-left:10px;
  height:32px;
  line-height: 30px;
  padding-top:0;
  padding-bottom:0;
}
.input-new-tag{
  width:90px;
  margin-left:10px;
  vertical-align: bottom;
}
</style>