pipeline {
    agent any

    environment {
        NETLIFY_SITE_ID = '2c9762ce-c9c2-4c4e-9855-3adeafe13b56'
        NETLIFY_AUTH_TOKEN = credentials('netlify-token')
    }

    stages {
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

        stage('Deploy') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    npm install netlify-cli@20.1.1 --no-audit --no-fund --ignore-scripts
                    node_modules/.bin/netlify --version
                    echo "DEPLOYING site Id: $NETLIFY_SITE_ID"
                    node_modules/.bin/netlify status
                    node_modules/.bin/netlify deploy  --dir=build --prod
                    
                '''
            }
        }

    }
}
