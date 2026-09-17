using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI; 
using TMPro;


public class FilterManager : MonoBehaviour
{
    [Header("UI Slider")]
    [SerializeField] private Slider timeSlider;
    [SerializeField] private TextMeshProUGUI yearDisplayLabel;

    [Header("UI Year Bounds")]
    [SerializeField] private TextMeshProUGUI dateMinLabel; 
    [SerializeField] private TextMeshProUGUI dateMaxLabel; 

    [Header("City Toggle Buttons")]
    [SerializeField] private Button akkadButton;
    [SerializeField] private Button urButton;
    [SerializeField] private Button urukButton;

    [Header("Resource Toggle Buttons")]
    [SerializeField] private Button barleyButton;
    [SerializeField] private Button soldiersButton;

    [Header("Navigation Screen Windows")]
    [SerializeField] private GameObject graphsViewWindow;
    [SerializeField] private GameObject mapViewWindow;
    [SerializeField] private GameObject databaseViewWindow;

    [Header("Navigation Buttons")]
    [SerializeField] private Button graphsViewButton;
    [SerializeField] private Button mapViewButton;
    [SerializeField] private Button databaseViewButton;

    [Header("Toggle Colors")]
    [SerializeField] private Color activeColor = Color.green;
    [SerializeField] private Color inactiveColor = Color.red;

    [Header("State Settings")]
    [SerializeField] private PipelineState runtimeStates = new PipelineState();

    [System.Serializable]
    public class PipelineState
    {
        public int currentYear;
        
        [Header("Active Filter Toggles")]
        public bool showAkkad = true;
        public bool showUr = true;
        public bool showUruk = true;
        public bool showBarley = true;
        public bool showSoldiers = false;

        [Header("Active Screen View")]
        public MainMenu currentMenu = MainMenu.Graphs; // ◄ REPLACED BOONS WITH ENUM
    }

    private List<DataRecord> allRecords = new List<DataRecord>();
    private List<IDataVisualizer> activeVisualizers = new List<IDataVisualizer>();

    public void InitializeData(List<DataRecord> records)
    {
        if (records == null || records.Count == 0) return;
        allRecords = records;

        activeVisualizers = FindObjectsByType<MonoBehaviour>(FindObjectsSortMode.None)
                            .OfType<IDataVisualizer>()
                            .ToList();

        SetupButtonListeners();
        UpdateButtonColors();
        
        // Boot up using the default enum state set in the Inspector
        SwitchMenu(runtimeStates.currentMenu);

        int minYear = allRecords.Min(r => r.year);
        int maxYear = allRecords.Max(r => r.year);

        if (dateMinLabel != null) dateMinLabel.text = minYear.ToString();
        if (dateMaxLabel != null) dateMaxLabel.text = maxYear.ToString();

        if (timeSlider != null)
        {
            timeSlider.minValue = minYear;
            timeSlider.maxValue = maxYear;
            timeSlider.wholeNumbers = true; 
            timeSlider.onValueChanged.RemoveAllListeners();
            timeSlider.onValueChanged.AddListener(OnSliderValueChanged);
            timeSlider.value = minYear;
            runtimeStates.currentYear = minYear;
            UpdatePipeline(); 
        }
    }

    private void SetupButtonListeners()
    {
        akkadButton.onClick.AddListener(() => { runtimeStates.showAkkad = !runtimeStates.showAkkad; OnToggleChanged(); });
        urButton.onClick.AddListener(() => { runtimeStates.showUr = !runtimeStates.showUr; OnToggleChanged(); });
        urukButton.onClick.AddListener(() => { runtimeStates.showUruk = !runtimeStates.showUruk; OnToggleChanged(); });
        
        barleyButton.onClick.AddListener(() => { runtimeStates.showBarley = !runtimeStates.showBarley; OnToggleChanged(); });
        soldiersButton.onClick.AddListener(() => { runtimeStates.showSoldiers = !runtimeStates.showSoldiers; OnToggleChanged(); });

        // Connect menu enum updates cleanly via inline listeners
        if (graphsViewButton != null) graphsViewButton.onClick.AddListener(() => SwitchMenu(MainMenu.Graphs));
        if (mapViewButton != null) mapViewButton.onClick.AddListener(() => SwitchMenu(MainMenu.Maps));
        if (databaseViewButton != null) databaseViewButton.onClick.AddListener(() => SwitchMenu(MainMenu.DataBases));
    }

    private void OnToggleChanged()
    {
        UpdateButtonColors();
        UpdatePipeline();
    }

    private void UpdateButtonColors()
    {
        SetButtonColor(akkadButton, runtimeStates.showAkkad);
        SetButtonColor(urButton, runtimeStates.showUr);
        SetButtonColor(urukButton, runtimeStates.showUruk);
        SetButtonColor(barleyButton, runtimeStates.showBarley);
        SetButtonColor(soldiersButton, runtimeStates.showSoldiers);

        // Update nav buttons using the current state color pairing layout
        SetButtonColor(graphsViewButton, runtimeStates.currentMenu == MainMenu.Graphs);
        SetButtonColor(mapViewButton, runtimeStates.currentMenu == MainMenu.Maps);
        SetButtonColor(databaseViewButton, runtimeStates.currentMenu == MainMenu.DataBases);
    }

    private void SetButtonColor(Button btn, bool isActive)
    {
        if (btn != null && btn.TryGetComponent(out Image img))
        {
            img.color = isActive ? activeColor : inactiveColor;
        }
    }

    // 🎛️ CENTRALIZED SWAPPING STATE MECHANIC
    public void SwitchMenu(MainMenu targetMenu)
    {
        runtimeStates.currentMenu = targetMenu;

        // Toggle windows based on the active enum selection state
        if (graphsViewWindow != null) graphsViewWindow.SetActive(targetMenu == MainMenu.Graphs);
        if (mapViewWindow != null) mapViewWindow.SetActive(targetMenu == MainMenu.Maps);
        if (databaseViewWindow != null) databaseViewWindow.SetActive(targetMenu == MainMenu.DataBases);

        // Instantly recolor navigation system buttons
        UpdateButtonColors();
        
        // Refresh active views
        UpdatePipeline();
    }

    private void OnSliderValueChanged(float value)
    {
        runtimeStates.currentYear = Mathf.RoundToInt(value);
        if (yearDisplayLabel != null) yearDisplayLabel.text = $"Year: {runtimeStates.currentYear} A. de C.";
        UpdatePipeline();
    }

    private void UpdatePipeline()
    {
        List<DataRecord> filteredData = FilterData();

        foreach (IDataVisualizer visualizer in activeVisualizers)
        {
            if (visualizer is PNGVisualization pngVis)
            {
                pngVis.SetResourceToggles(runtimeStates.showBarley, runtimeStates.showSoldiers);
            }
            visualizer.RenderData(filteredData);
        }
    }

    private List<DataRecord> FilterData()
    {
        return allRecords.Where(record => 
            record.year == runtimeStates.currentYear &&
            ((runtimeStates.showAkkad && record.city.Equals("Akkad", StringComparison.OrdinalIgnoreCase)) ||
             (runtimeStates.showUr && record.city.Equals("Ur", StringComparison.OrdinalIgnoreCase)) ||
             (runtimeStates.showUruk && record.city.Equals("Uruk", StringComparison.OrdinalIgnoreCase)))
        ).ToList();
    }



    public void ShowGraphsView()
    {
        SwitchMenu(MainMenu.Graphs);
    }

    public void ShowMapView()
    {
        SwitchMenu(MainMenu.Maps);
    }

    public void ShowDatabaseView()
    {
        SwitchMenu(MainMenu.DataBases);
    }
}
