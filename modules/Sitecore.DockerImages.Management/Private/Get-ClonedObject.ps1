# borrowed from https://github.com/RamblingCookieMonster/PSDepend/blob/master/PSDepend/Private/Get-ClonedObject.ps1
Function Get-ClonedObject {
    param($DeepCopyObject)
    $memStream = new-object IO.MemoryStream
    $formatter = new-object Runtime.Serialization.Formatters.Binary.BinaryFormatter
    $formatter.Serialize($memStream, $DeepCopyObject)
    $memStream.Position = 0
    $formatter.Deserialize($memStream)
}
