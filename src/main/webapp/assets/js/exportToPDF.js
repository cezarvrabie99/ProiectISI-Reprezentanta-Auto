function exportToPDF(table, fileName) {
    var doc = new jsPDF('l', 'pt', 'letter');
    var htmlstring = '';
    var tempVarToCheckPageHeight = 0;
    var pageHeight = 0;
    pageHeight = doc.internal.pageSize.height;
    specialElementHandlers = {
        // element with id of "bypass" - jQuery style selector
        '#bypassme': function (element, renderer) {
            // true = "handled elsewhere, bypass text extraction"
            return true
        }
    };
    margins = {
        top: 150,
        bottom: 60,
        left: 40,
        right: 40,
        width: 600
    };
    var y = 20;
    doc.setLineWidth(2);
    doc.text(400, y = y + 30, fileName);
    doc.autoTable({
        html: table,
        startY: 70,
        theme: 'grid'
    })
    doc.save(fileName + '.pdf');
}