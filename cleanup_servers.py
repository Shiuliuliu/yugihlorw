import subprocess
import sys

def main():
    ports = [8080, 8082, 8084, 8085, 9191, 9192, 9193]
    ps_cmd = (
        "$ports = @(" + ",".join(str(p) for p in ports) + "); "
        "foreach ($p in $ports) { "
        "Get-NetTCPConnection -LocalPort $p -ErrorAction SilentlyContinue | ForEach-Object { "
        "if ($_.OwningProcess -gt 4) { Stop-Process -Id $_.OwningProcess -Force -ErrorAction SilentlyContinue } "
        "} }; "
        "Stop-Process -Name cloudflared -Force -ErrorAction SilentlyContinue"
    )
    subprocess.run(["powershell", "-NoProfile", "-Command", ps_cmd], capture_output=True)
    print("    -> Da don dep xong cac cong game va Cloudflare tunnel cu.")

if __name__ == "__main__":
    main()
