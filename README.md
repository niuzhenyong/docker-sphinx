# sphinx 文档处理容器
基于 Docker 运行的 sphinx 文档处理系统，当前版本编号为 1.8.3 。通过该 Docker 容器可以生成 HTML、PDF 文档。容器内部包含了方正的四款免费字体（宋体、仿宋、黑体、楷体）。

## 查看容器内部字体列表

    docker run --rm niuzhenyong/sphinx fc-list

## 将 sphinx 文档生成 PDF (含中文字体)

1. 修改 sphinx 工作目录中的 conf.py 文件

        # 将生成引擎设置为 xelatex
        latex_engine = 'xelatex'

        latex_elements = {

           # 设置纸张大小为A4
           'papersize' : 'a4paper',
    
           # 设置为单面打印，如果为双面打印则删除此行
           'classoptions':',oneside',
    
           'preamble' : r'''
           \usepackage{xeCJK}
           \usepackage{indentfirst}
           \setlength{\parindent}{2em}
           \setCJKmainfont[BoldFont=FZHei-B01S, ItalicFont=FZFangSong-Z02S]{FZKai-Z03S}
    
           % 在有Babel多语言支持包的情况下这样设置
           \addto\captionsenglish{
               \renewcommand{\contentsname}{\huge 目\quad 录}
               \renewcommand{\listfigurename}{插图目录}
               \renewcommand{\listtablename}{表格目录}
               \renewcommand{\refname}{参考文献}
               \renewcommand{\abstractname}{摘要}
               \renewcommand{\indexname}{索引}
               \renewcommand{\tablename}{表}
               \renewcommand{\figurename}{图}
           }
    
           % 修改标题格式
           \usepackage{titlesec}
           \titleformat{\chapter}{\centering\huge\bfseries}{第\,\thechapter\,章}{1em}{}
               ''',
        }


1. 通过容器生成 PDF 文档

        docker run --rm -v <sphinx文档工程目录>:/doc niuzhenyong/sphinx make latexpdf

