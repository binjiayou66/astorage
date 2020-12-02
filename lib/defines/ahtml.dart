class AHtml {
  static const String uploadSimple = '''
<!DOCTYPE html>
<html>
<head>
	<title>Upload</title>
  <meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover,user-scalable=no">
</head>
<body>
  <form method="post" action="/upload" enctype="multipart/form-data">
    <input type="file" name="文件上传" /> <br /> <br />
    <button type="submit">开始上传</button?
  </form>
</body>
</html>
  ''';

  static const String upload = '''
<!DOCTYPE html>
<html>
<head>
	<title>Upload</title>
  <meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover,user-scalable=no">
  <style>
        .container{
            width:300px;height: 300px;
            border:2px dashed #ddd;
            text-align: center;
            padding:50px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<div class="container">
    拖拽进入
</div>
<form id="form1" method="post" enctype="multipart/form-data">
    <input type="file" name="file1" id="file1" value="" />
</form>
<script type="text/javascript">
    \$('.container').bind('dragenter dragover', ignoreDrag);
    \$(".container").on({drop:function(e){
        var flag=true;
        e.preventDefault();
        //jquery的file要去e.originalEvent里面拿，拖拽获取files的方式与input的不同
        var files = e.originalEvent.dataTransfer.files;
        //var files = e.dataTransfer.files;  原生的话这样就可以获取
        for(var i=0;i<files.length;i++){
            myFileReader(files[i],function(result,file){
                if(result){
                    //文件
                    console.log(file.name)
 
                }else{
                    //文件夹
                    console.log("不要上传文件夹")
                    flag=false;
                }
            });
        }
        if(flag){
            \$("#file1")[0].files=files;   //关键：将取到的文件赋值给input，用于ajax提交文件！！！
            var formData = new FormData(\$("#form1")[0]);     
            \$.ajax({
                url : "./upload",
                type : 'POST',
                data : formData,
                // 告诉jQuery不要去处理发送的数据
                processData : false,
                // 告诉jQuery不要去设置Content-Type请求头
                contentType : false,
                async : true,
                success : function(ret) {
                    if(ret){
                        alert("上传成功");
                    }
                }
            });
        }
        console.log(files);
    }})
 
    function ignoreDrag(e) {e.originalEvent.stopPropagation();
        e.originalEvent.preventDefault();
    }
 
    function myFileReader(file, callback){
        if(!window.FileReader){
            callback(true,file);
            return false;
        }
        var fr = new FileReader();
        fr.readAsDataURL(file);
        fr.onload=function(e){
            callback(true,file);
        }
        fr.onerror=function(e){  
            callback(false,file);
        }
        return true;
    };
</script>
</html>
  ''';
}
