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
	int upa_start,upa_end,tagNum,coord=0;
	char Chr[20],strand[20],tagNumC[20],coordC[20];
	fprintf(fd,"track name=\"PAC\" description=\"system PAC tagnum\" useScore=0\n");
	while(!feof(fp))
	{
		
		fscanf(fp,"%s\t%s\t%d\t%d\t%d\t%d\n",Chr,strand,&upa_start,&upa_end,&tagNum,&coord);
		char Pac[100]="PAC:";
		sprintf(tagNumC,"%d",tagNum);
		strcat(Pac,tagNumC);
		strcat(Pac,"@");
		sprintf(coordC,"%d",coord);
		strcat(Pac,coordC);
		fprintf(fd,"%s\t%d\t%d\t%s\t%d\t%s\n",Chr,upa_start-1,upa_end,Pac,tagNum,strand);
		
	}
	printf("work done!\n");
	fclose(fp);
	fclose(fd);
}
