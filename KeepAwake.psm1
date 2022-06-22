$code=@' 
[DllImport("kernel32.dll", CharSet = CharSet.Auto,SetLastError = true)]
  public static extern void SetThreadExecutionState(uint esFlags);
'@

$ste = Add-Type -memberDefinition $code -name System -namespace Win32 -passThru 
$ES_CONTINUOUS = [uint32]"0x80000000" #Requests that the other EXECUTION_STATE flags set remain in effect until SetThreadExecutionState is called again with the ES_CONTINUOUS flag set and one of the other EXECUTION_STATE flags cleared.
$ES_AWAYMODE_REQUIRED = [uint32]"0x00000040" #Requests Away Mode to be enabled.
$ES_DISPLAY_REQUIRED = [uint32]"0x00000002" #Requests display availability (display idle timeout is prevented).
$ES_SYSTEM_REQUIRED = [uint32]"0x00000001" #Requests system availability (sleep idle timeout is prevented).

function Suspend-Suspending {
    $ste::SetThreadExecutionState($ES_CONTINUOUS -bor $ES_SYSTEM_REQUIRED)
}
Export-ModuleMember Suspend-Suspending

function Resume-Suspending {
    $ste::SetThreadExecutionState($ES_CONTINUOUS)
}
Export-ModuleMember Resume-Suspending
