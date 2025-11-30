# PowerShell 测试脚本 - 新的 HTML 输入功能

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "测试 1: 基本的 HTML 转 Markdown" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$html1 = @{
    html = "<html><head><title>Test Article</title></head><body><h1>Hello World</h1><p>This is a <strong>test</strong> paragraph.</p><a href=`"https://example.com`">Click here</a></body></html>"
} | ConvertTo-Json

Invoke-WebRequest -Uri http://localhost:3000/ `
    -Method POST `
    -Headers @{"Content-Type"="application/json"; "X-Respond-With"="markdown"} `
    -Body $html1 | Select-Object -ExpandProperty Content

Write-Host ""
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "测试 2: 带 URL 的 HTML (用于相对链接处理)" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$html2 = @{
    html = "<h1>Article Title</h1><p>Some content</p><img src=`"/images/photo.jpg`" alt=`"Photo`"/><a href=`"/article`">Related</a>"
    url = "https://example.com/blog"
} | ConvertTo-Json

Invoke-WebRequest -Uri http://localhost:3000/ `
    -Method POST `
    -Headers @{"Content-Type"="application/json"; "X-Respond-With"="markdown"} `
    -Body $html2 | Select-Object -ExpandProperty Content

Write-Host ""
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "测试 3: 复杂的 HTML 内容" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$html3 = @{
    html = "<html><body><h1>Complete Article</h1><h2>Section 1</h2><p>First paragraph with <em>emphasis</em>.</p><ul><li>Point 1</li><li>Point 2</li><li>Point 3</li></ul><h2>Section 2</h2><pre><code>code sample</code></pre><blockquote>A quote</blockquote></body></html>"
    url = "https://example.com"
} | ConvertTo-Json

Invoke-WebRequest -Uri http://localhost:3000/ `
    -Method POST `
    -Headers @{"Content-Type"="application/json"; "X-Respond-With"="markdown"} `
    -Body $html3 | Select-Object -ExpandProperty Content

Write-Host ""
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "测试 4: 返回纯文本格式" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$html4 = @{
    html = "<h1>Title</h1><p>Some paragraph content</p>"
} | ConvertTo-Json

Invoke-WebRequest -Uri http://localhost:3000/ `
    -Method POST `
    -Headers @{"Content-Type"="application/json"; "X-Respond-With"="text"} `
    -Body $html4 | Select-Object -ExpandProperty Content

Write-Host ""
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "测试 5: 返回 HTML 格式" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$html5 = @{
    html = "<h1>Title</h1><p>Content</p>"
} | ConvertTo-Json

Invoke-WebRequest -Uri http://localhost:3000/ `
    -Method POST `
    -Headers @{"Content-Type"="application/json"; "X-Respond-With"="html"} `
    -Body $html5 | Select-Object -ExpandProperty Content

Write-Host ""
Write-Host ""
Write-Host "测试完成!" -ForegroundColor Green
