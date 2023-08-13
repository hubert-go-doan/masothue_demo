setTimeout(() => {
  let successAlert = document.getElementById('success-alert');
  if (successAlert) {
    successAlert.style.transition = 'top 0.2s, opacity 0.2s'; 
    successAlert.style.top = '100%'; 
    successAlert.style.opacity = '0';
    setTimeout(() => {
      successAlert.style.display = 'none';
    }, 4000);
  }
}, 4000);
