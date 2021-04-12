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
        <el-form-item label="内容" prop="content">
          <mavon-editor v-model="editForm.content"/>
        </el-form-item>
        <el-form-item style="margin: auto;">
          <el-button type="info" @click="temporarySave()">暂时保存</el-button>
          <el-button type="primary" @click="toSubmitForm('editForm')">发布文章</el-button>
        </el-form-item>
      </el-form>
    </div>

    <!-- 发布文章弹出的对话框 -->
    <el-dialog title="发布文章" :visible.sync="dialogFormVisible" width="35%">
      <el-form :model="editForm" ref="editForm2"><!--ref属性方便js获取dom节点-->
        <el-form-item label="文章标签" :label-width="formLabelWidth">
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
        <el-form-item label="分类专栏" prop="type_id" :label-width="formLabelWidth"
            :rules="{
              required: true, message: '分类专栏不能为空', trigger: 'blur'
            }"> 
          <el-select v-model="editForm.type_id" placeholder="请选择分类专栏"> 
            <el-option v-for="(item,idx) in getalltype" :key="idx" :label="item.name" :value="item.id + ''"></el-option>
          </el-select>
          <el-button type="primary" size="small" @click="dialog2 = true" style="margin-left:10px">新建分类专栏</el-button>
        </el-form-item>
        <el-form-item label="文章类型" prop="flag" :label-width="formLabelWidth"
            :rules="{
              required: true, message: '文章类型不能为空', trigger: 'blur'
            }">
          <el-select v-model="editForm.flag" placeholder="请选择文章类型，默认为原创">
            <el-option label="原创" value="原创"></el-option>
            <el-option label="转载" value="转载"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="发布形式" prop="published" :label-width="formLabelWidth"
            :rules="{
              required: true, message: '发布形式不能为空', trigger: 'blur'
            }">
          <el-select v-model="editForm.published" placeholder="请选择发布形式，默认为公开">
            <el-option label="公开" value=1></el-option>
            <el-option label="私密" value=0></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible=false" type="info">取消</el-button>
        <el-button @click="submitBlog('editForm2')" type="primary">确定</el-button>
      </div>
    </el-dialog>

    <!--新建专栏对话框-->
    <el-dialog 
      title="新建分类专栏"
      :visible.sync="dialog2"
      width="30%"
    >
      <el-form status-icon :model="type" ref="type" label-width="120px" :rules="rules3">
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
  name: 'WriteCon',
  data() {
    return {
      editForm:{
        id:null,
        title:"",
        description:"",
        first_picture:"",
        content:"",
        type_id:'',
        flag:'',
        published:null,
        tags:[],
      },
      editForm2:{//校验文章类型的表单
        type_id:null,
        flag:'',
        published:null
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
      }, 
      rules3: {//新建分类专栏校验
        name:[
          {required:true, message:"分类专栏名不能为空", trigger:"blur"}
        ],
      },
      type:{//新建分类专栏
        name:''
      },
      getalltype:[],//用于保存所有分类专栏
      dialogFormVisible:false,
      formLabelWidth:"120px",
      inputVisible:false,
      inputValue:'',
      dialog2:false,
    }
  },
  //生命周期 - 创建完成（访问当前this实例）
  created() {

  },
  mounted() {

  },
  methods:{
    temporarySave(){//保存草稿
      let that = this;
      this.$refs['editForm'].validate(valid=>{
        if(valid){
          that.postRequest('/blog/temporarySave',that.editForm).then(res=>{
            if(res){
              that.$message({
                message:"保存成功",
                type:"success"
              })
            }
          })
        }else{
          that.$message({
            message:"请填写必要字段!",
            type:"warning"
          })
        }
      })
      
    },
    toSubmitForm(editForm){//第一次点击发布 校验表单 并弹出标签选择框
      let that = this
      this.$refs[editForm].validate(valid=>{
        if(valid){
          that.dialogFormVisible = true;//显示对话框
          that.initType();//初始化文章专栏
        }
      })
    },
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
        console.log(res)
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
    submitBlog(editForm2){//最终提交博客
      let that = this;
      this.$refs[editForm2].validate(valid=>{
        if(valid){
          console.log(that.editForm)
          that.postRequest('/blog/saveBT',that.editForm).then(res=>{
            if(res){
              that.dialogFormVisible = false;
              that.$router.push('/admin/allblogs')
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