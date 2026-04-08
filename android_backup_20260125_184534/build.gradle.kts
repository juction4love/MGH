allprojects {
    repositories {
        google()
        mavenCentral()
        // THIS IS CRITICAL FOR FLUTTER ENGINE:
        maven { url = uri("https://storage.googleapis.com/download.flutter.io") }
    }
}
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)
subprojects {
    project.buildDir = File(newBuildDir.asFile, project.name)
    project.evaluationDependsOn(":app")
}
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
