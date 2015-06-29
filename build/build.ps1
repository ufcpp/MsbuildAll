$Script:msbuild = .\Get-VsPath.ps1

function build
{
    process
    {
        $Local:sln = $_

        ./NuGet.exe restore $Local:sln

        . $Script:msbuild $Local:sln /t:Build
    }
}

function build-dependecy
{
    process
    {
        $Local:repo = $_

        try
        {
            pushd $('..\..\' + $Local:repo + '\build')
            & .\build.ps1
        }
        finally
        {
            popd
        }
    }
}

cat ./solutions.txt | build

if (Test-Path dependency.txt)
{
    cat ./dependency.txt | build-dependecy
}

if (Test-Path postbuild.ps1)
{
    . ./postbuild.ps1
}
