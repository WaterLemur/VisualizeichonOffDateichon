using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI; 
using TMPro; // Crucial for using TextMeshProUGUI

public class FilterManager : MonoBehaviour
{
    [Header("UI Slider")]
    [SerializeField] private Slider timeSlider;
    [SerializeField] private TextMeshProUGUI yearDisplayLabel; // Displays current slider value

    [Header("UI Year Bounds")]
    [SerializeField] private TextMeshProUGUI dateMinLabel; // ◄ ADDED: Label for the lowest year
    [SerializeField] private TextMeshProUGUI dateMaxLabel; // ◄ ADDED: Label for the highest year

    private List<DataRecord> allRecords = new List<DataRecord>();

    public void InitializeData(List<DataRecord> records)
    {
        if (records == null || records.Count == 0) return;

        allRecords = records;

        // 1. DYNAMICALLY FIND MIN AND MAX YEARS
        int minYear = allRecords.Min(r => r.year);
        int maxYear = allRecords.Max(r => r.year);

        // 2. THIS IS WHERE THE LOGIC GOES TO SET YOUR LABELS!
        if (dateMinLabel != null)
        {
            dateMinLabel.text = minYear.ToString();
        }
        
        if (dateMaxLabel != null)
        {
            dateMaxLabel.text = maxYear.ToString();
        }

        // 3. CONFIGURE THE UI SLIDER
        if (timeSlider != null)
        {
            timeSlider.minValue = minYear;
            timeSlider.maxValue = maxYear;
            timeSlider.wholeNumbers = true; 

            timeSlider.onValueChanged.RemoveAllListeners();
            timeSlider.onValueChanged.AddListener(OnSliderValueChanged);

            timeSlider.value = minYear;
            OnSliderValueChanged(minYear);
        }
    }

    private void OnSliderValueChanged(float value)
    {
        int targetYear = Mathf.RoundToInt(value);

        if (yearDisplayLabel != null)
        {
            yearDisplayLabel.text = $"Year: {targetYear} A. de C.";
        }

        List<DataRecord> filteredData = FilterDataByYear(targetYear);
        
        // Pass filtered data down to graph renderer next!
    }

    private List<DataRecord> FilterDataByYear(int targetYear)
    {
        return allRecords.Where(record => record.year == targetYear).ToList();
    }
}
