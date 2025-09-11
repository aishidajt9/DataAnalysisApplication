// Fix TOC navigation links - corrects data-path attributes and href links
// This script addresses the bookdown 0.44 + pandoc 3.7 compatibility issue

(function() {
    // Mapping from chapter titles to correct HTML filenames
    const chapterMapping = {
        '記述統計の復習': '記述統計の復習.html',
        '推測統計の復習': '推測統計の復習.html',
        '線形代数の基礎(1)': '線形代数の基礎1.html',
        '線形代数の基礎(2)': '線形代数の基礎2.html',
        '単回帰分析(1)': '単回帰分析1.html',
        '単回帰分析(2)': '単回帰分析2.html',
        '重回帰分析(1)': '重回帰分析1.html',
        '重回帰分析(2)': '重回帰分析2.html',
        '重回帰分析(3)': '重回帰分析3.html',
        'ロジスティック回帰分析(1)': 'ロジスティック回帰分析1.html',
        'ロジスティック回帰分析(2)': 'ロジスティック回帰分析2.html'
    };

    // Find all chapter list items in the TOC
    const chapterItems = document.querySelectorAll('li.chapter[data-path="index.html"]');
    
    chapterItems.forEach(item => {
        // Get the link element and extract chapter title
        const link = item.querySelector('a');
        if (!link) return;
        
        const linkText = link.textContent.trim();
        
        // Extract chapter title (remove chapter number and leading text)
        // Look for patterns like "2 記述統計の復習" or "2. 記述統計の復習"
        const titleMatch = linkText.match(/^\d+\.?\s*(.+)$/);
        if (!titleMatch) return;
        
        const chapterTitle = titleMatch[1];
        
        // Check if we have a mapping for this chapter
        if (chapterMapping[chapterTitle]) {
            const correctFile = chapterMapping[chapterTitle];
            
            // Update data-path attribute
            item.setAttribute('data-path', correctFile);
            
            // Update href attribute
            link.setAttribute('href', correctFile);
            
            console.log(`Fixed TOC link: "${chapterTitle}" -> ${correctFile}`);
        }
    });
    
    console.log('TOC navigation links have been fixed');
})();