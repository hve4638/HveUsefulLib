{
  "optionsFile": "options.json",
  "options": [],
  "exportToGame": true,
  "supportedTargets": -1,
  "extensionVersion": "0.3.2",
  "packageId": "",
  "productId": "",
  "author": "",
  "date": "2020-11-05T19:41:28.7901878+09:00",
  "license": "",
  "description": "",
  "helpfile": "",
  "iosProps": false,
  "tvosProps": false,
  "androidProps": false,
  "installdir": "",
  "files": [
    {"filename":"customds.dll","origname":"","init":"","final":"","kind":1,"uncompress":false,"functions":[
        {"externalName":"info","kind":1,"help":"","hidden":false,"returnType":2,"argCount":0,"args":[],"resourceVersion":"1.0","name":"customds_info","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"trie_create","kind":1,"help":"","hidden":false,"returnType":2,"argCount":0,"args":[],"resourceVersion":"1.0","name":"ds_trie_create","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"trie_insert","kind":1,"help":"id, str","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            1,
          ],"resourceVersion":"1.0","name":"ds_trie_insert","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"trie_exists","kind":1,"help":"id","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
          ],"resourceVersion":"1.0","name":"ds_trie_exists","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"trie_destroy","kind":1,"help":"id","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
          ],"resourceVersion":"1.0","name":"ds_trie_destroy","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"trie_find","kind":1,"help":"id, str","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            1,
          ],"resourceVersion":"1.0","name":"_trie_node_find","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"trie_node_size","kind":1,"help":"id","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
          ],"resourceVersion":"1.0","name":"_trie_node_size","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"trie_node_find_value","kind":1,"help":"id, index","hidden":false,"returnType":1,"argCount":0,"args":[
            2,
            2,
          ],"resourceVersion":"1.0","name":"_trie_node_value","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"trie_node_destroy","kind":1,"help":"id","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
          ],"resourceVersion":"1.0","name":"_trie_node_destroy","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"seg_create","kind":1,"help":"","hidden":false,"returnType":2,"argCount":0,"args":[],"resourceVersion":"1.0","name":"ds_segment_create","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"seg_add","kind":1,"help":"id, pos, value","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            2,
            2,
          ],"resourceVersion":"1.0","name":"ds_segment_add","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"seg_set","kind":1,"help":"id, pos, value","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            2,
            2,
          ],"resourceVersion":"1.0","name":"ds_segment_set","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"seg_exists","kind":1,"help":"id","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
          ],"resourceVersion":"1.0","name":"ds_segment_exists","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"seg_destroy","kind":1,"help":"id","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
          ],"resourceVersion":"1.0","name":"ds_segment_destroy","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"seg_clear","kind":1,"help":"id","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
          ],"resourceVersion":"1.0","name":"ds_segment_clear","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"seg_sum","kind":1,"help":"id, start_pos, end_pos","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            2,
            2,
          ],"resourceVersion":"1.0","name":"ds_segment_sum","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"seg_get","kind":1,"help":"id, index","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            2,
          ],"resourceVersion":"1.0","name":"ds_segment_get","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"seg_all","kind":1,"help":"id","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
          ],"resourceVersion":"1.0","name":"ds_segment_all","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"seg_find","kind":1,"help":"id, value","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            2,
          ],"resourceVersion":"1.0","name":"ds_segment_find","tags":[],"resourceType":"GMExtensionFunction",},
      ],"constants":[
        {"value":"100","hidden":false,"resourceVersion":"1.0","name":"ds_type_trie","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"101","hidden":false,"resourceVersion":"1.0","name":"ds_type_segment","tags":[],"resourceType":"GMExtensionConstant",},
      ],"ProxyFiles":[],"copyToTargets":-1,"order":[
        {"name":"customds_info","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_trie_create","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_trie_insert","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_trie_exists","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_trie_destroy","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"_trie_node_find","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"_trie_node_size","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"_trie_node_value","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"_trie_node_destroy","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_segment_create","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_segment_add","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_segment_set","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_segment_exists","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_segment_destroy","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_segment_clear","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_segment_sum","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_segment_get","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_segment_all","path":"extensions/ext_customds/ext_customds.yy",},
        {"name":"ds_segment_find","path":"extensions/ext_customds/ext_customds.yy",},
      ],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
  ],
  "classname": "",
  "tvosclassname": null,
  "tvosdelegatename": null,
  "iosdelegatename": "",
  "androidclassname": "",
  "sourcedir": "",
  "androidsourcedir": "",
  "macsourcedir": "",
  "maccompilerflags": "",
  "tvosmaccompilerflags": "",
  "maclinkerflags": "",
  "tvosmaclinkerflags": "",
  "iosplistinject": null,
  "tvosplistinject": null,
  "androidinject": null,
  "androidmanifestinject": null,
  "androidactivityinject": null,
  "gradleinject": null,
  "iosSystemFrameworkEntries": [],
  "tvosSystemFrameworkEntries": [],
  "iosThirdPartyFrameworkEntries": [],
  "tvosThirdPartyFrameworkEntries": [],
  "IncludedResources": [],
  "androidPermissions": [],
  "copyToTargets": -1,
  "iosCocoaPods": "",
  "tvosCocoaPods": "",
  "iosCocoaPodDependencies": "",
  "tvosCocoaPodDependencies": "",
  "parent": {
    "name": "LibUseful",
    "path": "folders/LibUseful.yy",
  },
  "resourceVersion": "1.2",
  "name": "ext_customds",
  "tags": [],
  "resourceType": "GMExtension",
}