pipeline {
    agent { 
        dockerfile {
            args '--group-add=20 --privileged -v /dev/RFCAT_BL_YS1:/dev/RFCAT_BL_YS1'
        }
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
                sh './ci-scripts/configure-hubs.sh --off'
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
            // Clean after build
            sh './ci-scripts/configure-hubs.sh --reset'
            cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true)
        }
    }
}