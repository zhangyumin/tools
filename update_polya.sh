#!/bin/sh


#1.从数据库中导出相关的txt文件 select chr,strand,coord,$value from db_user.PAC_$value into outfile '../jbrowse/data/".$_SESSION['file']."/$value.txt
#2.处理txt文件，得到bedgraph文件 ./src/c/txt2bedgraph ../jbrowse/data/".$_SESSION['file']."/$value.txt ../jbrowse/data/".$_SESSION['file']."/$value.positive.bedGraph ../jbrowse/data/".$_SESSION['file']."/$value.negative.bedGraph
#3.整理文件形式 sort -k1,1 -k2,2n ../jbrowse/data/".$_SESSION['file']."/$value.positive.bedGraph > ../jbrowse/data/".$_SESSION['file']."/$value.positive.sorted.bedGraph
#4.去除重复 uniq -u ../jbrowse/data/".$_SESSION['file']."/$value.positive.sorted.bedGraph > ../jbrowse/data/".$_SESSION['file']."/$value.positive.sorted.uniq.bedGraph
#5.处理bedgraph文件，得到bw文件 ./src/c/bedGraphToBigWig ../jbrowse/data/".$_SESSION['file']."/$value.positive.sorted.bedGraph ./src/arab.sizes ../jbrowse/data/".$_SESSION['file']."/$value.UsrPosPA.bw
#6.给jbrowse目标文件夹提权 chmod -R 777 ../jbrowse/data/".$_SESSION['file']
#7.复制bw文件到jbrowse mv /var/www/front/src/arab.sizes /var/www/front/tojbrowse/$name.PosPA.bw /var/www/jbrowse/data/$des/$name.PosPA.bw
echo -n "=====================Step1: export PA file from mysql=====================\n";
read -p "请输入PA所在的数据库名，表名，列名，以空格分割 :" db table name
#mysql -uroot -proot -e"select chr,strand,coord,$name from $table" $db
mysql -uroot -proot -e"select chr,strand,coord,$name from $table where $name>0 into outfile '/var/www/front/tojbrowse/$name.txt'" $db;
echo -n "=====================Step2: txt to bedgraph===============================\n";
/var/www/front/src/c/txt2bedgraph /var/www/front/tojbrowse/$name.txt /var/www/front/tojbrowse/$name.positive.bedGraph /var/www/front/tojbrowse/$name.negative.bedGraph
echo -n "=====================Step3: sort files====================================\n";
sort -k1,1 -k2,2n /var/www/front/tojbrowse/$name.positive.bedGraph > /var/www/front/tojbrowse/$name.positive.sorted.bedGraph
sort -k1,1 -k2,2n /var/www/front/tojbrowse/$name.negative.bedGraph > /var/www/front/tojbrowse/$name.negative.sorted.bedGraph
echo -n "=====================Step4: unique files==================================\n";
uniq -u /var/www/front/tojbrowse/$name.positive.sorted.bedGraph > /var/www/front/tojbrowse/$name.positive.sorted.uniq.bedGraph
uniq -u /var/www/front/tojbrowse/$name.negative.sorted.bedGraph > /var/www/front/tojbrowse/$name.negative.sorted.uniq.bedGraph
echo -n "=====================Step5: bedgraph to bigwig============================\n";
read -p "请输入物种类型 ：" species
/var/www/front/src/c/bedGraphToBigWig /var/www/front/tojbrowse/$name.positive.sorted.uniq.bedGraph /var/www/front/src/$species.sizes /var/www/front/tojbrowse/$name.PosPA.bw
/var/www/front/src/c/bedGraphToBigWig /var/www/front/tojbrowse/$name.negative.sorted.uniq.bedGraph /var/www/front/src/$species.sizes /var/www/front/tojbrowse/$name.NegPA.bw
echo -n "=====================Step6: chmod jbrowse folder==========================\n";
read -p "请输入Jbrowse目标文件名，bw文件将会移入/var/www/jbrowse/data/{name}中去:" des
chmod 777 -R /var/www/jbrowse/data/$des/
echo -n "=====================Step7: move bw files=================================\n";
mv /var/www/front/tojbrowse/$name.PosPA.bw /var/www/jbrowse/data/$des/$name.PosPA.bw
mv /var/www/front/tojbrowse/$name.NegPA.bw /var/www/jbrowse/data/$des/$name.NegPA.bw
