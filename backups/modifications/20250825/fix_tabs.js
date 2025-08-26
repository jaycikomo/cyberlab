function showTab(tabName) {
    console.log('Switching to tab:', tabName);
    
    // Masquer tous les contenus
    const contents = document.querySelectorAll('.tab-content');
    contents.forEach(content => {
        content.classList.remove('active');
        content.style.display = 'none';
    });
    
    // Désactiver tous les onglets
    const tabs = document.querySelectorAll('.tab');
    tabs.forEach(tab => tab.classList.remove('active'));
    
    // Afficher le contenu sélectionné
    const targetContent = document.getElementById(tabName);
    if (targetContent) {
        targetContent.classList.add('active');
        targetContent.style.display = 'block';
    }
    
    // Activer l'onglet correspondant
    const activeTab = document.querySelector(`[onclick="showTab('${tabName}')"]`);
    if (activeTab) activeTab.classList.add('active');
    
    // Mettre à jour l'URL
    window.location.hash = tabName;
}

// Auto-activation selon URL hash
document.addEventListener('DOMContentLoaded', function() {
    const hash = window.location.hash.replace('#', '');
    if (hash && document.getElementById(hash)) {
        showTab(hash);
    } else {
        // Par défaut, afficher overview
        showTab('overview');
    }
});
