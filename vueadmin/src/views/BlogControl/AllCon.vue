<template>
  <div>
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="全部" name="allArts">
        <el-input size="small" v-model="input_title" placeholder="请输入标题" 
        prefix-icon="el-icon-search" style="width:300px;margin-right:20px">
        </el-input>
        <el-button size="small" type="primary" @click="search_title">搜索</el-button>
        <el-button size="small" type="primary">高级搜索</el-button>
        <BlogListCom :tindex="tabindex" v-if="tabindex == 0 && hidden_searchcom == false"></BlogListCom>
        <SearchBlogsCom v-if="tabindex == 0 && hidden_searchcom == true" :blogsData="blogsData"></SearchBlogsCom>
      </el-tab-pane>
      <el-tab-pane label="原创" name="originalArts">
        <BlogListCom :tindex="tabindex" v-if="tabindex == 1"></BlogListCom>
      </el-tab-pane>
      <el-tab-pane label="转载" name="reprintArts">
        <BlogListCom :tindex="tabindex" v-if="tabindex == 2"></BlogListCom>
      </el-tab-pane>
      <el-tab-pane label="草稿" name="draft">
        <BlogListCom :tindex="tabindex" v-if="tabindex == 3"></BlogListCom>
      </el-tab-pane>
      <el-tab-pane label="公开" name="publicArts">
        <BlogListCom :tindex="tabindex" v-if="tabindex == 4"></BlogListCom>
      </el-tab-pane>
      <el-tab-pane label="私密" name="privateArts">
        <BlogListCom :tindex="tabindex" v-if="tabindex == 5"></BlogListCom>
      </el-tab-pane>
      <el-tab-pane label="回收站" name="recycleBin">
        <BlogListCom :tindex="tabindex" v-if="tabindex == 6"></BlogListCom>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import BlogListCom from '@/components/blogs/BlogListCom'
import SearchBlogsCom from '@/components/blogs/SearchBlogsCom'
export default {
  name: 'AllCon',
  components:{BlogListCom,SearchBlogsCom},
  data() {
    return {
      activeName:"allArts",//一开始显示的栏目
      input_title:"",//搜索内容
      blogsData:[],
      tabindex:0,//栏目的序号
      hidden_searchcom:false
    }
  },
  //生命周期 - 创建完成（访问当前this实例）
  created() {

  },
  mounted() {

  },
  methods:{
    handleClick(tab){
      this.tabindex = tab.index;
    },
    search_title(){
      if(this.input_title == ""){//搜索内容为空白 无需发送请求
        this.hidden_searchcom = false;
      }else{//发送请求 并显示
        this.hidden_searchcom = true;
        let that = this;
        this.getRequest('/blog/getByTitle?title=' + this.input_title).then(res=>{
          if(res){
            that.blogsData = res.obj
            console.log(res.obj)
          }
        })
      }
      
    }
  }
}
</script>
<style scoped>

</style>