import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;
import 'package:arcore_projebir/main.dart';

import 'organ_model.dart';

class Custom3dObjectsScreen extends StatefulWidget {
  final Organ organObject;
  const Custom3dObjectsScreen({Key? key, required this.organObject})
      : super(key: key);

  @override
  State<Custom3dObjectsScreen> createState() => _Custom3dObjectsScreenState();
}

class _Custom3dObjectsScreenState extends State<Custom3dObjectsScreen> {
  ARSessionManager? sessionManager;
  ARObjectManager? objectManager;
  ARAnchorManager? anchorManager;
  List<ARNode> allNodes = [];
  List<ARAnchor> allAnchor = [];

  whenARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    sessionManager = arSessionManager;
    objectManager = arObjectManager;
    anchorManager = arAnchorManager;
    sessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      showWorldOrigin: true,
      handlePans: true,
      handleRotation: true,
    );
    objectManager!.onInitialize();
    sessionManager!.onPlaneOrPointTap = whenPlaneDetectedAndUserTapped;
    objectManager!.onPanStart = whenOnPanStarted;
    objectManager!.onPanChange = whenOnPanChanged;
    objectManager!.onPanEnd = whenOnPanEnded;
    objectManager!.onRotationStart = whenOnRotationStart;
    objectManager!.onRotationChange = whenOnRotationChange;
    objectManager!.onRotationEnd = whenOnRotationEnd;
  }

  whenOnPanStarted(String node3dObjectName) {
    print("Started Panning Node" + node3dObjectName);
  }

  whenOnPanChanged(String node3dObjectName) {
    print("Continued Panning Node" + node3dObjectName);
  }

  whenOnPanEnded(String node3dObjectName, Matrix4 transform) {
    print("Ending Panning Node" + node3dObjectName);
    final pannedNode =
        allNodes.firstWhere((node) => node.name == node3dObjectName);
  }

  whenOnRotationStart(String node3dObjectName) {
    print("Started Rotating Node" + node3dObjectName);
  }

  whenOnRotationChange(String node3dObjectName) {
    print("Continued Rotating Node" + node3dObjectName);
  }

  whenOnRotationEnd(String node3dObjectName, Matrix4 transform) {
    print("End Rotating Node" + node3dObjectName);
    final pannedNode =
        allNodes.firstWhere((node) => node.name == node3dObjectName);
  }

  Future<void> whenPlaneDetectedAndUserTapped(
      List<ARHitTestResult> tapResults) async {
    var userHitTestResult = tapResults
        .firstWhere((userTap) => userTap.type == ARHitTestResultType.plane);
    if (userHitTestResult != null) {
      var newPlaneARAnchor =
          ARPlaneAnchor(transformation: userHitTestResult.worldTransform);

      bool? isAnchorAdded = await anchorManager!.addAnchor(newPlaneARAnchor);
      if (isAnchorAdded!) {
        allAnchor.add(newPlaneARAnchor);

        var nodeNew3dObject = ARNode(
          type: NodeType.webGLB, // .glb 3d model
          uri: widget.organObject.modelKey,

          scale: vector64.Vector3(0.2, 0.2, 0.2),
          position: vector64.Vector3(0, 0, 0),
          rotation: vector64.Vector4(1.0, 0, 0, 0),
        );

        bool? isNodeAddedToNewAnchor = await objectManager!
            .addNode(nodeNew3dObject, planeAnchor: newPlaneARAnchor);

        if (isNodeAddedToNewAnchor!) {
          allNodes.add(nodeNew3dObject);
        } else {
          sessionManager!.onError("Hata");
        }
      } else {
        sessionManager!.onError("Hata-2");
      }
    }
  }

  Future<void> removeEveryObject() async {
    allAnchor.forEach((eachAnchor) {
      anchorManager!.removeAnchor(eachAnchor);
    });
    allAnchor = [];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sessionManager!.dispose();
  }

  void zoomIn() {
    if (allNodes.isNotEmpty) {
      final selectedNode = allNodes.first;
      final currentScale = selectedNode.scale;
      final newScale = vector64.Vector3(
        currentScale.x * 1.2,
        currentScale.y * 1.2,
        currentScale.z * 1.2,
      );

      setState(() {
        selectedNode.scale = newScale;
      });
    }
  }

  void zoomOut() {
    if (allNodes.isNotEmpty) {
      final selectedNode = allNodes.first;
      final currentScale = selectedNode.scale;
      final newScale = vector64.Vector3(
        currentScale.x * 0.8,
        currentScale.y * 0.8,
        currentScale.z * 0.8,
      );

      setState(() {
        selectedNode.scale = newScale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ARView(
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            onARViewCreated: whenARViewCreated,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      zoomOut();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.remove, color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      zoomIn();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
