pipeline {
    agent { 
        dockerfile {
            args '--group-add=20 --device-cgroup-rule="c 189:* rmw" -v /dev/bus/usb:/dev/bus/usb --device-cgroup-rule="c 166:* rmw" -v /dev/rfcat:/dev/rfcat'
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
                retry(3) {
                    sh 'ls /sys/class/'
                    sh 'ls /sys/class/tty/'
                    sh 'ls -l /dev/'
                    sh 'ls -l /dev/rfcat/'
                    sh 'tail -f /dev/null'
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