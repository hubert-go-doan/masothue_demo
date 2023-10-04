$(document).on('turbo:load', () => {
  const yearSelect = $('#selected-year');

  yearSelect.on('change', () => {
    const selectedYear = yearSelect.val();
    const currentURL = window.location.href;
    const regex = /year=\d{4}/;
    
    if (regex.test(currentURL)) {
      const newURL = currentURL.replace(regex, `year=${selectedYear}`);
      window.location.href = newURL;
    } else {
      const separator = currentURL.includes('?') ? '&' : '?';
      const newURL = `${currentURL}${separator}year=${selectedYear}`;
      window.location.href = newURL;
    }
  });
});
