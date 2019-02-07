#!groovy

pipeline {
    agent {
        label "docker"
    }
    options {
        timestamps()
        timeout(time: 1, unit: 'HOURS')
        buildDiscarder(logRotator(numToKeepStr: '30', artifactNumToKeepStr: '5'))
        disableConcurrentBuilds()
    }
    environment {
        UPLOADER_VERSION = '1.0'
    }
    stages {
        stage('Build branch version') {
            when {
                not {
                    anyOf { branch 'develop'; branch 'master' }
                }
            }
            steps {
                script {
                    withDockerRegistry(credentialsId: 'Docker-Registry') {
                        sh "docker build --rm -t starwarsfan/github-release-uploader:latest ."
                    }
                }
            }
        }
        stage('Build and push develop version') {
            when {
                branch 'develop'
            }
            steps {
                script {
                    withDockerRegistry(credentialsId: 'Docker-Registry') {
                        sh(
                                script: """
                                    docker build --rm -t starwarsfan/github-release-uploader:latest .
                                    docker push starwarsfan/github-release-uploader:latest
                                """
                        )
                    }
                }
            }
        }
        stage('Build and push release') {
            when {
                branch 'master'
            }
            steps {
                script {
                    withDockerRegistry(credentialsId: 'Docker-Registry') {
                        sh(
                                script: """
                                    docker build --rm -t starwarsfan/github-release-uploader:${UPLOADER_VERSION} .
                                    docker push starwarsfan/github-release-uploader:${UPLOADER_VERSION}
                                """
                        )
                    }
                }
            }
        }
    }
    post {
        always {
            sh "docker system prune --all --force"
        }
    }
}
