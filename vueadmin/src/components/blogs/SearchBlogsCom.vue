<template>
  <div>
    <el-table :data="blogsData" stripe style="width:100%"><!--stripe默认值为false 禁用斑马纹-->
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
                {{scope.row.published == "0" ? '私密' : "公开"}}
              </el-tag>
              <el-tag size="small" style="margin-right:30px"
              v-if="scope.row.shareStatement" type="success">{{scope.row.tag}}</el-tag>
              <i style="margin-right:20px" class="el-icon-view">{{scope.row.views}}</i>
              <i style="margin-right:20px" class="el-icon-chat-square">{{scope.row.commentCount}}</i>
              <i style="margin-right:20px" class="el-icon-date">{{scope.row.createTime}}</i>
              <el-button style="float:right" size="mini" type="danger">删除</el-button>
              <el-button style="float:right;margin-right:10px;" size="mini" type="primary">编辑</el-button>
            </div>
          </el-card>
        </template>
      </el-table-column> 
    </el-table>
  </div>
</template>

<script>
export default {
  name: 'SearchBlogsCom',
  data() {
    return {
      
    }
  },
  props:["blogsData"],//父组件传值
  created() {

  },
  mounted() {

  },
  methods:{

  }
  }
</script>
<style scoped>

</style>