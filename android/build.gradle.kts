allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// बिल्ड डाइरेक्टरीलाई प्रोजेक्टकै डिफल्ट फोल्डरमा सेट गर्ने
rootProject.layout.buildDirectory.set(file("${project.projectDir}/../build"))

subprojects {
    val newSubprojectBuildDir: Directory = rootProject.layout.buildDirectory.dir(project.name).get()
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}