pipeline {
    agent any

    environment {
        NETLIFY_SITE_ID = '2c9762ce-c9c2-4c4e-9855-3adeafe13b56'
        NETLIFY_AUTH_TOKEN = credentials('netlify-token')
    }

    stages {
        stage('Docker') {
            steps {
                sh 'docker build -t my-playwright .'
            }
        }
        stage('Build') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    ls -la
                    node --version
                    npm --version
                    npm ci
                    npm run build
                    ls -la

                '''
            }
        }
        stage('Test') {
            steps {
                sh 'echo Test page'
            }
        }

        stage('Deploy staging') {
            agent {
                docker {
                    image 'my-playwright'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    
                    netlify --version
                    echo "DEPLOYING site Id: $NETLIFY_SITE_ID"
                    netlify status
                    netlify deploy  --dir=build 
                    
                '''
            }
        }
        stage('Deploy prod') {
            agent {
                docker {
                    image 'my-playwright'
                    reuseNode true
                }
            }
            steps {
                sh '''
                   
                    netlify --version
                    echo "DEPLOYING site Id: $NETLIFY_SITE_ID"
                    netlify status
                    netlify deploy  --dir=build --prod
                    
                '''
            }
        }


    }
}
