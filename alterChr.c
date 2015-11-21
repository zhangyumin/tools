#include<stdio.h>
#include<stdlib.h>
void main()
{
	FILE *fp,*fd,*ft;
	if((fp=fopen("PAT.bed","r"))==NULL)
	{
		printf("can't open txt files\n");
		exit(0);
	}
	if((fd=fopen("PAT1.bed","w"))==NULL)
	{
		printf("can't open bed files\n");
		exit(0);
	}
	//char buffer[100];
	int b,coord1,coord2,tagNum=0;
	char Chr[10],strand[10];
	char a[10];
	fprintf(fd,"track name=\"polyA site\" description=\"polyA site\" useScore=0\n");
	while(!feof(fp))
	{
		
		fscanf(fp,"%s\t%d\t%d\t%s\t%d\t%s\n",Chr,&coord1,&coord2,a,&b,strand);
		if(Chr[0]=='C'&&Chr[1]=='h'&&Chr[2]=='r')
		{
			Chr[0]=Chr[3];
			Chr[1]='\0';
		}
		fprintf(fd,"%s\t%d\t%d\t%s\t%d\t%s\n",Chr,coord1,coord1+1,a,b,strand);
		
	}
	printf("work done!\n");
	fclose(fp);
	fclose(fd);
}
