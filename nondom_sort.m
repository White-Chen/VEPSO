function ind = nondom_sort( ind )
%NONDOM_SORT2 ���з�֧����������չ֧��ֲ�
%�βΣ�    ind ����
%���أ�    ind �ѷֲ�  
%   ��֧������
    numInd = numel(ind);
    objVar=[ind.Cost];
    numObj = length(objVar)/numInd;
    objVar = reshape(objVar',[numObj,numInd]);
    
    front=1;
    group(front).f=[];
    for i=1:numInd;
        x(i).n=0;    %��֧��ĸ�����
        x(i).s=[];
        for j=1:numInd;
            if(j==i)
                continue;
            end
            domless=0;
            domequa=0;
            dommore=0;
            for k=1:numObj;
                if(objVar(k,i)<objVar(k,j))
                    domless=domless+1;
                elseif(objVar(k,i)>objVar(k,j))
                    dommore=dommore+1;
                else
                    domequa=domequa+1;
                end
            end
            if(domless==0&&domequa~=numObj)
                x(i).n=x(i).n+1;
            elseif(dommore==0&&domequa~=numObj)
                x(i).s=[x(i).s j];
            end
        end
        if(x(i).n==0)
            ind(i).numlies=1;
            group(front).f=[group(front).f i];
        end
    end
    %�ֲ�
    while ~isempty(group(front).f)
        H=[];
        for i=1:length(group(front).f)
            if(~isempty(x(group(front).f(i)).s))
                for j=1:length(x(group(front).f(i)).s)
                    x(x(group(front).f(i)).s(j)).n=x(x(group(front).f(i)).s(j)).n-1;
                    if(x(x(group(front).f(i)).s(j)).n==0)
                        H=[H x(group(front).f(i)).s(j)];
                        ind(x(group(front).f(i)).s(j)).numlies=front+1;
                    end
                end
            end
        end
        front=front+1;
        group(front).f=H;
    end
end

