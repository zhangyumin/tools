#!/bin/sh

#1.从数据库中导出pac文件	select chr,strand,coord,$tag_num from pac_arab10 into outfile '/var/www/html/front/tojbrowse/pac.txt
#2.处理txt文件，得到bedgraph文件 ./txt2bed /var/www/front/tojbrowse/pac_arab.txt /var/www/front/tojbrowse/pac_arab.bed
#3.使用flatfile-to-json导入bed文件 /var/www/html/jbrowse/bin/flatfile-to-json.pl --bed /var/www/html/front/tojbrowse/pac.bed --trackLabel usrPac --out /var/www/html/jbrowse/data/

echo -n "=========================Step1: export PAC file from mysql=================\n";
read -p "请输入PAC所在的数据库名，物种名，以空格分割 :" db species
mysql -uroot -proot -e"select chr,strand,UPA_start,UPA_end,ref_tagnum from t_"$species"_pac where ref_tagnum>0 into outfile '/var/www/front/tojbrowse/PAC_$species.txt'" $db;
echo -n "=========================Step2: bed file to jbrowse========================\n";
/var/www/front/src/c/txt2bed /var/www/front/tojbrowse/PAC_$species.txt /var/www/front/tojbrowse/PAC_$species.bed
echo -n "=========================Step3: txt to bed=================================\n";
read -p "请输入Jbrowse目标文件名，bw文件将会移入/var/www/jbrowse/data/{name}中去 以空格键分割 :" des
chmod 777 -R /var/www/jbrowse/data/$des/
/var/www/jbrowse/bin/flatfile-to-json.pl --bed /var/www/front/tojbrowse/PAC_$species.bed --trackLabel "APAplant stored PAC" --out /var/www/jbrowse/data/$des/
jq '(.tracks[-1]) |= . +{"menuTemplate" : [{"url" : "../front/converse.php?species='$species'&chr={Seq_id}&strand={strand}&coord={start}","iconClass" : "digitIconDatabase","action" : "newwindow","label" : "go PAC","title" : "go PAC"}]}' /var/www/jbrowse/data/$des/trackList.json > /var/www/jbrowse/data/$des/trackList1.json
rm -rf /var/www/jbrowse/data/$des/trackList.json
mv /var/www/jbrowse/data/$des/trackList1.json /var/www/jbrowse/data/$des/trackList.json

