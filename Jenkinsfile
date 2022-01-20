pipeline {
    agent { 
        dockerfile {
            args '--group-add=20 --privileged -v /dev/bus/usb:/dev/bus/usb'
        }
    }
    options {
        throttleJobProperty(
            categories: ['single-build-throttle'],
            throttleEnabled: true,
            throttleOption: 'category'
        )
    }
    environment {
        GIT_COMMITER_NAME = 'CI Person'
        GIT_COMMITER_EMAIL = 'ci@greatscottgadgets.com'
    }
    stages {
        stage('Build') {
            steps {
                sh './ci-scripts/build-host.sh'
            }
        }
        stage('Test') {
            steps {
                sh './ci-scripts/test-hub.sh'
                retry(3) {
                    sh './ci-scripts/test-firmware.sh'
                }
                retry(3) {
                    sh './ci-scripts/test-host.sh'
                }
            }
        }
    }
    post {
        always {
            echo 'One way or another, I have finished'
            // Clean after build
            cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true)
        }
    }
}