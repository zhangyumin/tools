#include<stdio.h>
#include<stdlib.h>
#include<string.h>
void main(int argc,char *argv[])
{
	FILE *fp,*fd;
	if((fp=fopen(argv[1],"r"))==NULL)
	{
		printf("can't open txt files\n");
		exit(0);
	}
	if((fd=fopen(argv[2],"w"))==NULL)
	{
		printf("can't open bed files\n");
		exit(0);
	}
	//char buffer[100];
	int upa_start,upa_end,tagNum=0;
	char Chr[10],strand[10],tagNumC[10];
	fprintf(fd,"track name=\"PAC\" description=\"system PAC tagnum\" useScore=0\n");
	while(!feof(fp))
	{
		
		fscanf(fp,"%s\t%s\t%d\t%d\t%d\n",Chr,strand,&upa_start,&upa_end,&tagNum);
		char Pac[]="PAC:";
		sprintf(tagNumC,"%d",tagNum);
		strcat(Pac,tagNumC);
		fprintf(fd,"%s\t%d\t%d\t%s\t%d\t%s\n",Chr,upa_start,upa_end,Pac,tagNum,strand);
		
	}
	printf("work done!\n");
	fclose(fp);
	fclose(fd);
}
