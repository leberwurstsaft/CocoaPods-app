import Cocoa

class CPMetadataTableViewDataSource: NSObject, NSTableViewDataSource, NSTableViewDelegate {

  var flattenedXcodeProject: [AnyObject] = []

  @IBOutlet weak var tableView: NSTableView!

  func setXcodeProjects(projects:[CPXcodeProject]) {
    flattenedXcodeProject = flattenXcodeProjects(projects)
    tableView.reloadData()
  }

  // TODO: I bet someone could code-golf this pretty well
  private func flattenXcodeProjects(projects:[CPXcodeProject]) -> [AnyObject] {
    var flattenedObjects: [AnyObject] = []

    for xcodeproject in projects {
      flattenedObjects.append(xcodeproject)
      for target in xcodeproject.targets {
        flattenedObjects.append(target)
        for pod in target.pods {
          flattenedObjects.append(pod)
        }
      }
    }
    return flattenedObjects
  }

  func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
    return false
  }

  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return flattenedXcodeProject.count
  }

  func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
    return flattenedXcodeProject[row]
  }

  func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let data = flattenedXcodeProject[row]
    if let xcodeproj = data as? CPXcodeProject {
      return tableView.makeViewWithIdentifier("xcodeproject_metadata", owner: xcodeproj)

    } else if let target = data as? CPTarget {
      return tableView.makeViewWithIdentifier("target_metadata", owner: target)

    } else if let pod = data as? CPPod {
      return tableView.makeViewWithIdentifier("pod_metadata", owner: pod)
    }

    print("Should not have data unaccounted for in the flattened xcode project");
    return nil
  }

  func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
    let data = flattenedXcodeProject[row]
    if let _ = data as? CPXcodeProject {
      return 150

    } else if let _ = data as? CPTarget {
      return 150

    } else if let _ = data as? CPPod {
      return 30
    }

    return 0
  }
}