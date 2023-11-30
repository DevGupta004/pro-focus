
echo $@


######### Command Line Parameters Parsing Starting ###################
POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    --appName)
      appName="$2"
      shift # past argument
      shift # past value
      ;;
    --2)
      2="$2"
      shift # past argument
      shift # past value
      ;;
    --default)
      DEFAULT=YES
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters


packageLocation=${2//.//}

echo "packageLocation:::::${packageLocation}"
echo "2:::::${2}"




# Initilize Project Base/path
if [[ "$OSTYPE" == "darwin"* ]]; then
  projectBase="./"
else
  projectBase="/AAB/DaVinchiRN/"
fi

cd $projectBase



if [ -e ./android/app/src/main/java/$packageLocation/newarchitecture/MainApplicationReactNativeHost.java ]
then
  echo "newarchitecture exists"
else
  echo "newarchitecture don't exist, creating it manually"
    if [[ "$OSTYPE" == "darwin"* ]]; then
      cp -r AAB/myapp/newarchitecture/ ${projectBase}android/app/src/main/java/$packageLocation/ && \
      sed -i "" "s/com.mycompany.myapp/$2/g" ${projectBase}android/app/src/main/java/$packageLocation/newarchitecture/MainApplicationReactNativeHost.java && \
      sed -i "" "s/com.mycompany.myapp/$2/g" ${projectBase}android/app/src/main/java/$packageLocation/newarchitecture/components/MainComponentsRegistry.java && \
      sed -i "" "s/com.mycompany.myapp/$2/g" ${projectBase}android/app/src/main/java/$packageLocation/newarchitecture/modules/MainApplicationTurboModuleManagerDelegate.java
      if [ $? -eq 0 ]; then
        echo OK
      else
        exit 1
      fi

    else
      cp -r myapp/newarchitecture/ ${projectBase}android/app/src/main/java/$packageLocation/ && \
      sed -i "s/com.mycompany.myapp/$2/g" ${projectBase}android/app/src/main/java/$packageLocation/newarchitecture/MainApplicationReactNativeHost.java && \
      sed -i "s/com.mycompany.myapp/$2/g" ${projectBase}android/app/src/main/java/$packageLocation/newarchitecture/components/MainComponentsRegistry.java && \
      sed -i "s/com.mycompany.myapp/$2/g" ${projectBase}android/app/src/main/java/$packageLocation/newarchitecture/modules/MainApplicationTurboModuleManagerDelegate.java
      if [ $? -eq 0 ]; then
        echo OK
      else
        exit 1
      fi
    fi

fi