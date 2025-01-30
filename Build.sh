dotnet --version
dotnet restore
dotnet build --configuration Release
dotnet pack --configuration Release --output ./output -p:Version=1.0.${BUILD_NUMBER}
octo push --package ./output/<ProjectName>.1.0.${BUILD_NUMBER}.nupkg --server <ServerName> --apikey <API key>
octo create-release --project <ProjectName> --deployto Development --server <ServerName> --apiKey <API key> --progress
