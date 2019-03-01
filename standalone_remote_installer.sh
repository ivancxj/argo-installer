#!/bin/bash
set -e


function install()
{
    set -e
    if [ ""$osType == "centos7" ];then
        baseUrl="$repo_url/analysys_installer_base_centos7.tar.gz"
        basemd5Url="$repo_url/analysys_installer_base_centos7.tar.gz.md5"
        arkUrl="$repo_url/ark_$targetVersion/ark_centos7_$targetVersion.tar.gz"
        arkmd5Url="$repo_url/ark_$targetVersion/ark_centos7_$targetVersion.tar.gz.md5"
    elif [ ""$osType == "centos6" ];then
        baseUrl="$repo_url/analysys_installer_base_centos6.tar.gz"
        basemd5Url="$repo_url/analysys_installer_base_centos6.tar.gz.md5"
        arkUrl="$repo_url/ark_$targetVersion/ark_centos6_$targetVersion.tar.gz"
        arkmd5Url="$repo_url/ark_$targetVersion/ark_centos6_$targetVersion.tar.gz.md5"
    else
        echo "不支持的操作系统版本"
        exit 1
    fi



    echo "******************************************************************************"
    echo -e "\033[42;34m ==============开始下载基础安装包......================= \033[0m"
    echo "sudo yum install wget -y -d 0 -e 0"
    sudo yum install wget -y -d 0 -e 0
    cd /opt/soft

    if [ -f /opt/soft/analysys_installer_base_$osType.tar.gz ];then
        echo "已存在基础安装包，检查文件完整性..."
        echo " "
        echo " "
        if [ -f /opt/soft/analysys_installer_base_$osType.tar.gz.md5 ];then
            rm -rf /opt/soft/analysys_installer_base_$osType.tar.gz.md5
        fi
        wget -c -O  /opt/soft/analysys_installer_base_$osType.tar.gz.md5 $basemd5Url
        set +e
        checksum=`md5sum -c  analysys_installer_base_$osType.tar.gz.md5`
        set -e

        if [[ "$checksum" == analysys_installer_base_$osType.tar.gz:*  ]];then
            echo "文件完整，跳过下载"
            echo " "
            echo " "
        else
            echo "文件不完整，重新下载..."
            echo " "
            echo " "
            rm -rf /opt/soft/analysys_installer_base_$osType.tar.gz
            wget -c -O /opt/soft/analysys_installer_base_$osType.tar.gz $baseUrl
            rm -rf /opt/soft/analysys_installer_base_$osType.tar.gz.md5
            wget -c -O  /opt/soft/analysys_installer_base_$osType.tar.gz.md5 $basemd5Url
            set +e
            checksum=`md5sum  -c  analysys_installer_base_$osType.tar.gz.md5`
            set -e
            if [[ "$checksum" == analysys_installer_base_$osType.tar.gz:* ]];then
                echo "文件完整，下载成功"
                echo " "
                echo " "
            else
                echo "文件不完整，下载失败，可能是源出了问题，请联系我们！"
                exit 1
            fi
        fi
    else
        wget -c -O  /opt/soft/analysys_installer_base_$osType.tar.gz $baseUrl

        if [ -f /opt/soft/analysys_installer_base_$osType.tar.gz.md5 ];then
            rm -rf /opt/soft/analysys_installer_base_$osType.tar.gz.md5
        fi

        wget -c -O  /opt/soft/analysys_installer_base_$osType.tar.gz.md5 $basemd5Url

        set +e
        checksum=`md5sum  -c  analysys_installer_base_$osType.tar.gz.md5`
        set -e
        if [[ "$checksum" == analysys_installer_base_$osType.tar.gz:* ]];then
            echo "文件完整，下载成功"
            echo " "
            echo " "
        else
            echo "文件不完整，下载失败，可能是源出了问题，请联系我们！"
            exit 1
        fi

    fi


    echo "******************************************************************************"
    echo -e "\033[42;34m ==============开始下载$targetVersion安装包......================= \033[0m"

    if [ -f /opt/soft/ark_${osType}_$targetVersion.tar.gz ];then
        echo "已存在ark_${osType}_$targetVersion.tar.gz安装包，检查文件完整性..."
        echo " "
        echo " "
        if [ -f /opt/soft/ark_${osType}_$targetVersion.tar.gz.md5 ];then
            rm -rf /opt/soft/ark_${osType}_$targetVersion.tar.gz.md5
        fi
        wget -c -O  /opt/soft/ark_${osType}_$targetVersion.tar.gz.md5 $arkmd5Url
        set +e
        checksum=`md5sum  -c   ark_${osType}_$targetVersion.tar.gz.md5`
        set -e
        if [[ "$checksum" == ark_${osType}_$targetVersion.tar.gz:* ]];then
            echo "文件完整，跳过下载"
            echo " "
            echo " "
        else
            echo "文件不完整，重新下载..."
            echo " "
            echo " "
            rm -rf /opt/soft/ark_${osType}_$targetVersion.tar.gz
            wget -c -O  /opt/soft/ark_${osType}_$targetVersion.tar.gz $arkUrl
            rm -rf /opt/soft/ark_${osType}_$targetVersion.tar.gz.md5
            wget -c -O  /opt/soft/ark_${osType}_$targetVersion.tar.gz.md5 $arkmd5Url
            set +e
            checksum=`md5sum -c ark_${osType}_$targetVersion.tar.gz.md5`
            set -e
            if [[ "$checksum" == ark_${osType}_$targetVersion.tar.gz:* ]];then
                echo "文件完整，下载成功"
                echo " "
                echo " "
            else
                echo "文件不完整，下载失败，可能是源出了问题，请联系我们！"
                exit 1
            fi
        fi
    else
        wget -c -O  /opt/soft/ark_${osType}_$targetVersion.tar.gz $arkUrl

        if [ -f /opt/soft/ark_${osType}_$targetVersion.tar.gz.md5 ];then
            rm -rf /opt/soft/ark_${osType}_$targetVersion.tar.gz.md5
        fi

        wget -c -O  /opt/soft/ark_${osType}_$targetVersion.tar.gz.md5 $arkmd5Url
        set +e
        checksum=`md5sum -c ark_${osType}_$targetVersion.tar.gz.md5`
        set -e
        if [[ "$checksum" == ark_${osType}_$targetVersion.tar.gz:* ]];then
            echo "文件完整，下载成功"
            echo " "
            echo " "
        else
            echo "文件不完整，下载失败，可能是源出了问题，请联系我们！"
            exit 1
        fi

    fi


    echo "******************************************************************************"
    echo -e "\033[42;34m ==============开始解压安装包......================= \033[0m"
    cd /opt/soft
    echo "tar -zxf analysys_installer_base_centos7.tar.gz ..."
    tar -zxf analysys_installer_base_centos7.tar.gz
    echo "tar -zxf ark_${osType}_$targetVersion.tar.gz ..."
    tar -zxf ark_${osType}_$targetVersion.tar.gz
    cd analysys_installer


    echo "******************************************************************************"
    echo -e "\033[42;34m ==============开始初始化系统参数...================= \033[0m"
    sudo sh init_ext4.sh


    echo "******************************************************************************"
    echo -e "\033[42;34m ==============开始自动修改安装参数......================= \033[0m"



    #修改ship.name参数
    blueprint="1node-${node_memory}g-ark-hdp2.6.1.0"
    cluster_defi_file="${blueprint}/cluster-defi.properties"
    sudo sed -i  "s/ship\.name=UNKNOW/ship\.name=${cluster_name}/" /opt/soft/analysys_installer/tool/ark-blueprint/conf/${cluster_defi_file}


    #修改host.file文件
    echo "ark1.analysys.xyz:${install_user}:${install_user_password}" > /opt/soft/analysys_installer/host.file

    #修改邮件告警模板文件
    sudo sed -i  "s/北京易观/${cluster_name}/" /opt/soft/analysys_installer/tool/alert-templates-custom.xml


    echo "******************************************************************************"
    echo -e "\033[42;34m ==============开始安装......================= \033[0m"
    cd /opt/soft/analysys_installer
    echo "sh analysys_install.sh ark1.analysys.xyz 22 $mysql_root_password $blueprint $osType $install_user 1"

    sh analysys_install.sh ark1.analysys.xyz 22 $mysql_root_password $blueprint $osType $install_user 1

}

if [ $# -lt 1 ];then
  echo "sh standalone_remote_installer.sh install mysql_root_password version osType install_user install_user_password cluster_name(只能是英文和数字) node_memory(机器内存支持32,64,128这3个值)"
  echo "sh standalone_remote_installer.sh upgrade version osType"
  exit 1
fi

export action=$1



if [ ""$action == "install" ];then
    if [ $# -ne 8 ];then
      echo "sh standalone_remote_installer.sh install mysql_root_password version osType install_user install_user_password cluster_name(只能是英文和数字) node_memory(机器内存支持32,64,128这3个值)"
      echo "sh standalone_remote_installer.sh upgrade version osType"
      exit 1
    fi
    export mysql_root_password=$2
    export targetVersion=$3
    export osType=$4
    export install_user=$5
    export install_user_password=$6
    export cluster_name=$7
    export node_memory=$8
    repo_url=`grep repo_url config.properties`
    repo_url=${repo_url##*=}
    export repo_url

    if [ ""$repo_url == ""  ];then
        echo "请先配置config.properties文件中的源地址"
        exit
    fi

    if [ $node_memory -ne 32 -a $node_memory -ne 64 -a $node_memory -ne 128 ];then
        echo "node_memory只支持32，64，128，不支持其它值"
        exit
    fi

    if echo "$cluster_name" | grep -q '^[a-zA-Z0-9]\+$'; then
            echo "OK"
    else
            echo "cluster_name 参数的值 $cluster_name 非法，只能是字母和数字"
            exit 1
    fi


    echo "检查是否已经安装了方舟..."
    set +e
    hadoop version
    if [ $?"" -eq 0 ];then
        echo "检查到您已经安装了方舟或大数据平台hadoop相关的服务，如果您已经安装了方舟，请使用upgrade命令升级到你想要的版本，如果没有安装方舟，请你更换一台没有安装过任何大数据组件的机器！"
        exit 1
    fi
    install

elif [ ""$action == "upgrade" ];then
    echo "暂不支持！"
    exit 1


#    echo "检查是否已经安装了方舟..."
#    CHECK01=`netstat -anlupt |grep '0.0.0.0:8080' |grep -v grep |wc -l` &> /dev/null
#    if [ $CHECK01 -ne 1 ];then
#        echo "您还没有安装过方舟，请先使用install命令安装方舟！"
#        exit 1
#    else
#        echo "您已经安装了方舟，检查您的版本..."
#        if [ -f /var/lib/ambari-server/resources/common-services/ARK_STREAMING/0.3.3/package/files/soft_version ];then
#            currentVersion=`cat /var/lib/ambari-server/resources/common-services/ARK_STREAMING/0.3.3/package/files/soft_version`
#            vltV=`vlt $currentVersion $targetVersion`
#            if [ $vltV -eq 0 ];then
#                echo "目标版本 $targetVersion 比当前版本 $currentVersion 小，无法升级！"
#                exit 1
#            fi

#        else
#            echo "您方舟的版本小于4.1.1.1，无法自动检查版本号，您可以通过方舟产品界面查看您的版本号，请确保您要升级到的目标版本 $targetVersion 大于您当前的版本号，不然升级会出错!"
#        fi
#    fi
#
#    read -p "是否继续 [y/n]: " choi
#
#    if [ $choi = y ] || [ $choi = Y ] ;then
#        upgrade
#    else
#        echo "放丢升级！"
#        exit 0
#    fi

fi


## 字符串$1 小于 字符串$2
vlt(){
    if [ $# -lt 2  ] ;then
            echo "参数错误"
            return 1
    fi

    [ $1 = $2 ] && return 1

    litter=$(echo -e "$1\n$2" | sort | head -n1)

    if [ $litter = $1 ] ;then
            return 0
    else
            return 1
    fi
}







