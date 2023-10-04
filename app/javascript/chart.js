$(document).on('turbo:load', () => {
  const timeSelect = $('#selected-time-interval');
  const yearSelect = $('#selected-year');
  const monthSelect = $('#selected-month');
  const quarterSelect = $('#selected-quarter');
  const updateButton = $('#update-button');

  if (timeSelect.val() === 'Year') {
    monthSelect.hide();
    quarterSelect.hide();
  }

  if (timeSelect.val() === 'Month') {
    monthSelect.show();
    quarterSelect.hide();
  }
  
  if (timeSelect.val() === 'Quarter') {
    quarterSelect.show();
    monthSelect.hide();
  }

  let selectedYear, selectedMonth, selectedQuarter;

  timeSelect.on('change', () => {
    const selectedTime = timeSelect.val();
    monthSelect.hide();
    quarterSelect.hide();

    if (selectedTime === 'Year') {
      yearSelect.show();
    } else if (selectedTime === 'Month') {
      yearSelect.show();
      monthSelect.show();
    } else if (selectedTime === 'Quarter') {
      yearSelect.show();
      quarterSelect.show();
    }
    updateButton.show();
  });

  yearSelect.on('change', () => {
    selectedYear = yearSelect.val();
  });

  monthSelect.on('change', () => {
    selectedYear = yearSelect.val();
    selectedMonth = monthSelect.val();
  });

  quarterSelect.on('change', () => {
    selectedYear = yearSelect.val();
    selectedQuarter = quarterSelect.val();
  });

  updateButton.on('click', () => {
    updateChart(selectedYear, selectedMonth, selectedQuarter);
  });

  function updateChart(year, month, quarter) {
    let url = '/charts';
    const selectedTime = timeSelect.val();
    if (year) {
      url += `?time=${selectedTime}&year=${year}`;
      if (month) {
        url += `&month=${month}`;
      }  
      if (quarter) {
        url += `&quarter=${quarter}`;
      }
    }
    window.location.href = url;
  }
});
