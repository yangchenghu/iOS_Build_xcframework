## !/bin/sh

# 如何使用：
# echo "sh ./buildFramework.sh libx265 3.0"


CLIENT_WORKSPACE="$PWD"
BUILD_WORKSPACE=${CLIENT_WORKSPACE}
##进入编译目录
cd ${BUILD_WORKSPACE}


XCWORKSPACE_NAME='PodsHost'  #'请输入当前.xcworkspace名称'
FRAMEWORK_NAME=$1 #'请输入当前.xcworkspace下的framework名称'
VERSION=$2

OUTPUT_DIR=${BUILD_WORKSPACE}/Build/Products
DEVICE_OUTPUT_DIR=${OUTPUT_DIR}/Release-iphoneos
SIMULATOR_OUTPUT_DIR=${OUTPUT_DIR}/Release-iphonesimulator

#清空OUTPUT_DIR
rm -rf ${OUTPUT_DIR}

#ios release
xcodebuild -workspace ${XCWORKSPACE_NAME}.xcworkspace -scheme ${FRAMEWORK_NAME} -destination="iOS" -sdk iphoneos -configuration Release SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES -derivedDataPath ./

#ios simulator release
xcodebuild -workspace ${XCWORKSPACE_NAME}.xcworkspace -scheme ${FRAMEWORK_NAME} -destination="iOS Simulator"  -sdk iphonesimulator -configuration Release SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES -derivedDataPath ./


XCFRAMEWORKPATH=${OUTPUT_DIR}/${FRAMEWORK_NAME}-${VERSION}.xcframework
#如果输出目录存在，即移除该目录，再创建该目录。目的是为了清空输出目录。
if [ -d ${XCFRAMEWORKPATH} ]; then
rm -rf ${XCFRAMEWORKPATH}
fi


file ${DEVICE_OUTPUT_DIR}/${FRAMEWORK_NAME}/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME} | grep -q "dynamically"

if [ $? -ne 0 ] ;then
# 没找到，这里走静态库合并
echo "合并静态库"

# 这个 命令合并成 fat lib
# lipo -create $BIN_DIR_TMP/*-${TARGET_NAME}.framework/${TARGET_NAME} -output ${BIN_DIR}/${TARGET_NAME}.framework/${TARGET_NAME}

# 静态库没有 dsym
xcodebuild -create-xcframework -framework ${DEVICE_OUTPUT_DIR}/${FRAMEWORK_NAME}/${FRAMEWORK_NAME}.framework  -framework ${SIMULATOR_OUTPUT_DIR}/${FRAMEWORK_NAME}/${FRAMEWORK_NAME}.framework  -output ${XCFRAMEWORKPATH}

else 
echo "合并动态库"
#将打包好的framwork合并成xcframework
xcodebuild -create-xcframework -framework ${DEVICE_OUTPUT_DIR}/${FRAMEWORK_NAME}/${FRAMEWORK_NAME}.framework -debug-symbols ${DEVICE_OUTPUT_DIR}/${FRAMEWORK_NAME}/${FRAMEWORK_NAME}.framework.dSYM -framework ${SIMULATOR_OUTPUT_DIR}/${FRAMEWORK_NAME}/${FRAMEWORK_NAME}.framework -debug-symbols ${SIMULATOR_OUTPUT_DIR}/${FRAMEWORK_NAME}/${FRAMEWORK_NAME}.framework.dSYM -output ${XCFRAMEWORKPATH}

fi

#打开输出目录
open ${OUTPUT_DIR}