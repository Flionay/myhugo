+++
author = "Angyi"
comments = true	# set false to hide Disqus
date= 2019-07-18T19:59:58+08:00
draft = false
	# set "main" to add this content to the 
share = true	# set false to hide share buttons
tags = ["html"]
categories=["其他"]
toc= true
title = "利用ACE打造Python在线代码编辑器 "
Summary = "  网页中的代码编辑器，支持多种语言，高亮以及智能提示.....  "

+++

[ace官网](https://ace.c9.io)



[ace github](<https://github.com/ajaxorg/ace/>)



```git
git clone git@github.com:ajaxorg/ace.git
```
首先将github将项目克隆下来，一般只需要lib中的`\ace-master\lib\ace`,将ace放到项目中同一个目录下，直接写`html`

```html

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>web编辑器</title>
  <style type="text/css" media="screen">
    #box {
      width: 100%;
      height: 800px;
    }

    #editor {
      width: 100%;
      height: 100%;
    }

    .ace_print-margin {
      display: none;
    }
  </style>
</head>

<body>
   <div id="box">
    <div id="editor">

    </div>
  </div>
  <!-- 主要文件 -->
  <script src="https://cdn.bootcss.com/ace/1.4.2/ace.js"></script>
  <!-- 用来提供代码提示和自动补全的插件 -->
  <script src="https://cdn.bootcss.com/ace/1.4.2/ext-language_tools.js"></script>
  <script>
    // ace.require("ace/ext/language_tools");
    // 初始化editor(）
    var editor = ace.edit("editor");
    editor.setOptions({
      // 默认:false
      wrap: true, // 换行
      // autoScrollEditorIntoView: false, // 自动滚动编辑器视图
      enableLiveAutocompletion: true, // 智能补全
      enableSnippets: true, // 启用代码段
      enableBasicAutocompletion: true, // 启用基本完成 不推荐使用
    });
    // 设置主题  cobalt monokai
    editor.setTheme("ace/theme/cobalt");
    // 设置编辑语言
    editor.getSession().setMode("ace/mode/python");
    editor.setFontSize(18);
    editor.setReadOnly(false)
    editor.getSession().setTabSize(2);
    // 获取编辑内容
    // var v = editor.getValue();
    // console.log(v);
    // 编辑内容搜索  快捷键打开->ctrl+f
    // editor.execCommand('find');
    // 设置编辑内容
    // var editorValue = '<h2>测试数据</h2>';
    // editor.setValue(editorValue);
  </script>
</body>

</html>


```

![效果图](https://github.com/Flionay/myhugo/blob/master/hugoblog/static/images/B98T$WSKD55%5D5%5DC4EB%257X0I.png?raw=true)



ps:还有一个业界好评的插件，也是后来者居上的，名字叫做`codemirror`，但是我在用它做一个网页弹窗的时候，会出现**行号错位**，**缩进乱码**的问题，弄了好久没有解决。`github`中有`issue`提到了这个问题，很多人利用`autorefresh`解决了，但是我还是不行，可能是我能力有限。最终换到了ACE，结果发现:

>  姜还是老的辣，稳定简单好使。高亮和提示都很棒。



