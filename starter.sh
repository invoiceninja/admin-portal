#!/bin/bash

# https://github.com/hillelcoren/flutter-redux-starter
echo "Flutter/Redux Starter by @hillelcoren"

[ $# -eq 0 ] && { echo "Usage: $0 init or $0 make <module-name>"; exit 1; }

action="$1"
lineBreak='\'$'\n'

if [ ${action} = "init" ]; then

    company="$2"
    package="$3"
    url="$4"

    echo "Company: $company"
    echo "Package: $package"
    echo "URL: $url"

    flutter pub get

    echo "Creating files..."

    sed -i -e "s/__API_URL__/$url/g" ./lib/constants.dart

    mv "./android/app/src/main/java/com/hillelcoren" "./android/app/src/main/java/com/$company"
    mv "./android/app/src/main/java/com/$company/flutterreduxstarter" "./android/app/src/main/java/com/$company/$package"

    # Replace 'hillelcoren'
    declare -a files=(
        './ios/Runner.xcodeproj/project.pbxproj'
        './android/app/build.gradle'
        './android/app/src/main/AndroidManifest.xml'
        "./android/app/src/main/java/com/$company/$package/MainActivity.java")

    for i in "${files[@]}"
    do
       sed -i -e "s/hillelcoren/$company/g" $i
    done

    # Replace 'flutterReduxStarter'
    declare -a files=(
        "./android/app/src/main/java/com/$company/$package/MainActivity.java")

    for i in "${files[@]}"
    do
       sed -i -e "s/flutterReduxStarter/$package/g" $i
    done

    # Replace 'flutterreduxstarter'
    declare -a files=(
        "./ios/Runner.xcodeproj/project.pbxproj")

    for i in "${files[@]}"
    do
       sed -i -e "s/flutterreduxstarter/$package/g" $i
    done

    declare -a files=(
        './.packages'
        './pubspec.yaml'
        './ios/Runner/Info.plist'
        './ios/Flutter/Generated.xcconfig'
        './android/app/build.gradle'
        './android/app/src/main/AndroidManifest.xml'
        './lib/main.dart'
        './lib/redux/app/app_state.dart'
        './lib/redux/app/app_reducer.dart'
        './lib/redux/app/app_actions.dart'
        './lib/redux/app/app_middleware.dart'
        './lib/redux/app/data_reducer.dart'
        './lib/redux/auth/auth_state.dart'
        './lib/redux/auth/auth_actions.dart'
        './lib/redux/auth/auth_middleware.dart'
        './lib/redux/auth/auth_reducer.dart'
        './lib/redux/ui/ui_actions.dart'
        './lib/redux/ui/ui_reducer.dart'
        './lib/redux/ui/entity_ui_state.dart'
        './lib/redux/ui/list_ui_state.dart'
        './lib/data/repositories/auth_repository.dart'
        './lib/data/repositories/persistence_repository.dart'
        './lib/data/models/serializers.dart'
        './test/login_test.dart'
        './lib/redux/ui/ui_state.dart'
        './lib/ui/auth/mock_login.dart'
        './lib/ui/auth/login_vm.dart'
        './lib/ui/app/menu_drawer.dart'
        './lib/ui/app/init.dart'
        './lib/ui/app/menu_drawer_vm.dart'
        './lib/ui/app/actions_menu_button.dart'
        './lib/ui/app/app_bottom_bar.dart'
        './lib/ui/app/app_search.dart'
        './lib/ui/app/app_search_button.dart'
        './lib/ui/app/dismissible_entity.dart'
        './lib/ui/home/home_screen.dart'
        './stubs/data/models/stub_model'
        './stubs/data/repositories/stub_repository'
        './stubs/redux/stub/stub_actions'
        './stubs/redux/stub/stub_reducer'
        './stubs/redux/stub/stub_state'
        './stubs/redux/stub/stub_middleware'
        './stubs/redux/stub/stub_selectors'
        './stubs/ui/stub/edit/stub_edit'
        './stubs/ui/stub/edit/stub_edit_vm'
        './stubs/ui/stub/view/stub_view'
        './stubs/ui/stub/view/stub_view_vm'
        './stubs/ui/stub/stub_list_item'
        './stubs/ui/stub/stub_list_vm'
        './stubs/ui/stub/stub_list'
        './stubs/ui/stub/stub_screen')

    for i in "${files[@]}"
    do
       sed -i -e "s/flutter_redux_starter/$package/g" $i
    done

else

    package="$2"
    module_snake="$3"
    module_camel="$4"
    Module="$(tr '[:lower:]' '[:upper:]' <<< ${module_camel:0:1})${module_camel:1}"
    fields="$5"
    IFS=', ' read -r -a fieldsArray <<< "$fields"

    echo "Make..."
    echo "Creating module: $module_snake"

    # Create new directories
    if [ ! -d "lib/redux/$module_snake" ]
    then
       echo "Creating directory: lib/redux/$module_snake"
       mkdir "lib/redux/$module_snake"
    fi

    if [ ! -d "lib/ui/$module_snake" ]
    then
       echo "Creating directory: lib/ui/$module_snake"
       mkdir "lib/ui/$module_snake"
    fi

    if [ ! -d "lib/ui/$module_snake/view" ]
    then
       echo "Creating directory: lib/ui/$module_snake/view"
       mkdir "lib/ui/$module_snake/view"
    fi

    if [ ! -d "lib/ui/$module_snake/edit" ]
    then
       echo "Creating directory: lib/ui/$module_snake/edit"
       mkdir "lib/ui/$module_snake/edit"
    fi

    # Create new module files
    declare -a files=(
       #'./stubs/data/models/stub_model'
       './stubs/data/repositories/stub_repository'
       './stubs/redux/stub/stub_actions'
       './stubs/redux/stub/stub_reducer'
       './stubs/redux/stub/stub_state'
       './stubs/redux/stub/stub_middleware'
       './stubs/redux/stub/stub_selectors'
       './stubs/ui/stub/edit/stub_edit'
       './stubs/ui/stub/edit/stub_edit_vm'
       './stubs/ui/stub/view/stub_view'
       './stubs/ui/stub/view/stub_view_vm'
       './stubs/ui/stub/stub_list_item'
       './stubs/ui/stub/stub_list_vm'
       './stubs/ui/stub/stub_list'
       './stubs/ui/stub/stub_screen')

    for i in "${files[@]}"
    do
       filename=$(echo $i | sed "s/stubs/lib/g" | sed "s/stub/$module_snake/g")
       echo "Creating file: $filename.dart"
       cp $i "$filename.dart"
       sed -i -e "s/stub_/${module_snake}_/g" "$filename.dart"
       sed -i -e "s/\/stub/\/${module_snake}/g" "$filename.dart"
       sed -i -e "s/stub/$module_camel/g" "$filename.dart"
       sed -i -e "s/Stub/$Module/g" "$filename.dart"
    done

    # Link in new module
    comment="STARTER: import - do not remove comment"
    code="import 'package:${package}\/redux\/${module_snake}\/${module_snake}_state.dart';${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/app/app_state.dart

    comment="STARTER: states switch - do not remove comment"
    code="case EntityType.${module_camel}:${lineBreak}return ${module_camel}UIState;${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/app/app_state.dart

    comment="STARTER: state getters - do not remove comment"
    code="${Module}State get ${module_camel}State => selectedCompanyState.${module_camel}State;${lineBreak}"
    code="${code}ListUIState get ${module_camel}ListState => uiState.${module_camel}UIState.listUIState;${lineBreak}"
    code="${code}${Module}UIState get ${module_camel}UIState => uiState.${module_camel}UIState;${lineBreak}${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/app/app_state.dart

    for (( idx=${#fieldsArray[@]}-1 ; idx>=0 ; idx-- )) ; do
        elements="${fieldsArray[idx]}"
        IFS=':' read -r -a elementArray <<< "$elements"

        element="${elementArray[0]}"
        type="${elementArray[1]}"
        Element="$(tr '[:lower:]' '[:upper:]' <<< ${element:0:1})${element:1}"

        comment="STARTER: fields - do not remove comment"
        code="static const String ${element} = '${element}';${lineBreak}"
        #sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/data/models/${module_snake}_model.dart"

        comment="STARTER: properties - do not remove comment"
        code="String get ${element};${lineBreak}"
        #sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/data/models/${module_snake}_model.dart"

        comment="STARTER: sort switch - do not remove comment"
        code="case ${Module}Fields.${element}:${lineBreak}"
        code="${code}response = ${module_snake}A.${element}.compareTo(${module_snake}B.${element});${lineBreak}break;${lineBreak}"
        #sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/data/models/${module_snake}_model.dart"

        comment="STARTER: filter - do not remove comment"
        code="if (${element}.toLowerCase().contains(filter)){${lineBreak}"
        code="${code}return true;${lineBreak}"
        code="${code}}${lineBreak}"
        #sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/data/models/${module_snake}_model.dart"

        comment="STARTER: constructor - do not remove comment"
        code="${element}: '',${lineBreak}"
        #sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/data/models/${module_snake}_model.dart"

        comment="STARTER: controllers - do not remove comment"
        code="final _${element}Controller = TextEditingController();${lineBreak}"
        sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/ui/${module_snake}/edit/${module_snake}_edit.dart"

        comment="STARTER: array - do not remove comment"
        code="_${element}Controller,${lineBreak}"
        sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/ui/${module_snake}/edit/${module_snake}_edit.dart"

        comment="STARTER: read value - do not remove comment"
        code="_${element}Controller.text = ${module_snake}.${element};${lineBreak}"
        sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/ui/${module_snake}/edit/${module_snake}_edit.dart"

        comment="STARTER: set value - do not remove comment"
        code="..${element} = _${element}Controller.text.trim()${lineBreak}"
        sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/ui/${module_snake}/edit/${module_snake}_edit.dart"

        comment="STARTER: widgets - do not remove comment"
        code="TextFormField(${lineBreak}"
        code="${code}controller: _${element}Controller,${lineBreak}"
        code="${code}autocorrect: false,${lineBreak}"
        if [ "$type" = "textarea" ]; then
           code="${code}maxLines: 4,${lineBreak}"
        fi
        code="${code}decoration: InputDecoration(${lineBreak}"
        code="${code}labelText: '${Element}',${lineBreak}"
        code="${code}),${lineBreak}"
        code="${code}),${lineBreak}"
        sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/ui/${module_snake}/edit/${module_snake}_edit.dart"

        #comment="STARTER: widgets - do not remove comment"
        #if [ ${element} = ${fieldsArray[0]} ]; then
        #    code="Text(${module_snake}.${element}, style: Theme.of(context).textTheme.headline6),${lineBreak}"
        #    code="${code}SizedBox(height: 12.0),${lineBreak}"
        #else
        #    code="Text(${module_snake}.${element}),"
        #fi
        #sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/ui/${module_snake}/view/${module_snake}_view.dart"

        comment="STARTER: sort - do not remove comment"
        code="${Module}Fields.${element},${lineBreak}"
        sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/ui/${module_snake}/${module_snake}_screen.dart"

        if [ "$idx" -eq 0 ]; then
            comment="STARTER: sort default - do not remove comment"
            code="return ${module_camel}A.${element}.compareTo(${module_camel}B.${element});${lineBreak}"
            sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/data/models/${module_snake}_model.dart"

            comment="STARTER: display name - do not remove comment"
            code="return ${element};${lineBreak}"
            sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/data/models/${module_snake}_model.dart"
        fi

        if [ "$idx" -eq 1 ]; then
            comment="STARTER: subtitle - do not remove comment"
            code="subtitle: Text(${module_camel}.${element}, maxLines: 4),${lineBreak}"
            #sed -i -e "s/$comment/$comment${lineBreak}$code/g" "./lib/ui/${module_snake}/${module_snake}_item.dart"
        fi
    done


    comment="STARTER: import - do not remove comment"
    code="import 'package:${package}\/ui\/${module_snake}\/${module_snake}_screen.dart';${lineBreak}"
    code="${code}import 'package:${package}\/ui\/${module_snake}\/edit\/${module_snake}_edit_vm.dart';${lineBreak}"
    code="${code}import 'package:${package}\/ui\/${module_snake}\/view\/${module_snake}_view_vm.dart';${lineBreak}"
    code="${code}import 'package:${package}\/redux\/${module_snake}\/${module_snake}_actions.dart';${lineBreak}"
    code="${code}import 'package:${package}\/redux\/${module_snake}\/${module_snake}_middleware.dart';${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/main.dart

    comment="STARTER: middleware - do not remove comment"
    code="..addAll(createStore${Module}sMiddleware())${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/main.dart

    comment="STARTER: routes - do not remove comment"
    code="${Module}Screen.route: (context) => ${Module}Screen(),${lineBreak}"
    code="${code}${Module}ViewScreen.route: (context) => ${Module}ViewScreen(),${lineBreak}"
    code="${code}${Module}EditScreen.route: (context) => ${Module}EditScreen(),${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/main.dart

    comment="STARTER: import - do not remove comment"
    code="import 'package:${package}\/data\/models\/${module_snake}_model.dart';${lineBreak}"
    code="${code}import 'package:${package}\/redux\/${module_snake}\/${module_snake}_state.dart';${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/data/models/serializers.dart

    comment="STARTER: serializers - do not remove comment"
    code="${Module}Entity,${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/data/models/serializers.dart

    comment="STARTER: import - do not remove comment"
    code="import 'package:${package}\/redux\/${module_snake}\/${module_snake}_state.dart';${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/company/company_state.dart

    comment="STARTER: fields - do not remove comment"
    code="${Module}State get ${module_camel}State;${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/company/company_state.dart

    comment="STARTER: constructor - do not remove comment"
    code="${module_camel}State: ${Module}State(),${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/company/company_state.dart

    comment="STARTER: import - do not remove comment"
    code="import 'package:${package}\/redux\/${module_snake}\/${module_snake}_reducer.dart';${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/company/company_reducer.dart

    comment="STARTER: reducer - do not remove comment"
    code="..${module_camel}State.replace(${module_camel}sReducer(state.${module_camel}State, action))${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/company/company_reducer.dart

    comment="STARTER: import - do not remove comment"
    code="import 'package:${package}\/redux\/${module_snake}\/${module_snake}_actions.dart';${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/ui/app/menu_drawer.dart

    comment="STARTER: menu - do not remove comment"
    code="DrawerTile(${lineBreak}"
    code="${code}company: company,${lineBreak}"
    code="${code}entityType: EntityType.${module_camel},${lineBreak}"
    code="${code}icon: getEntityIcon(EntityType.${module_camel}),${lineBreak}"
    code="${code}title: localization.${module_camel}s,${lineBreak}"
    code="${code}onTap: () => store.dispatch(View${module_camel}List(context)),${lineBreak}"
    code="${code}onCreateTap: () {${lineBreak}"
    code="${code}navigator.pop();${lineBreak}"
    code="${code}store.dispatch(Edit${Module}(${lineBreak}"
    code="${code}${module_camel}: ${Module}Entity(), context: context));${lineBreak}"
    code="${code}},${lineBreak}"
    code="${code}),${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/ui/app/menu_drawer.dart

    comment="STARTER: import - do not remove comment"
    code="import 'package:${package}\/redux\/${module_snake}\/${module_snake}_state.dart';${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/ui/ui_state.dart

    comment="STARTER: properties - do not remove comment"
    code="${Module}UIState get ${module_camel}UIState;${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/ui/ui_state.dart

    comment="STARTER: constructor - do not remove comment"
    code="${module_camel}UIState: ${Module}UIState(),${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/ui/ui_state.dart

    comment="STARTER: import - do not remove comment"
    code="import 'package:${package}\/redux\/${module_snake}\/${module_snake}_reducer.dart';${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/ui/ui_reducer.dart

    comment="STARTER: reducer - do not remove comment"
    code="..${module_camel}UIState.replace(${module_camel}UIReducer(state.${module_camel}UIState, action))${lineBreak}"
    sed -i -e "s/$comment/$comment${lineBreak}$code/g" ./lib/redux/ui/ui_reducer.dart

    echo "Generating built files.."
    flutter packages pub run build_runner clean
    flutter packages pub run build_runner build --delete-conflicting-outputs
fi

echo "Successfully completed"