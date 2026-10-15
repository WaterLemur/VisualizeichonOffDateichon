using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PNGVisualization : MonoBehaviour, IDataVisualizer
{
    [Header("Presentation Component")]
    [SerializeField] private Image uiImageDisplay;

    [Header("Texture Dimensions")]
    [SerializeField] private int textureWidth = 512;
    [SerializeField] private int textureHeight = 512;

    [Header("Visual Colors")]
    [SerializeField] private Color barleyColor = new Color(0.9f, 0.72f, 0.22f);   // Golden Yellow
    [SerializeField] private Color soldiersColor = new Color(0.22f, 0.44f, 0.71f); // Steel Blue
    [SerializeField] private Color backgroundColor = Color.white;
    [SerializeField] private int marginPadding = 40; // Pixel space saved around the edge

    [Header("Data Tuning")]
    [SerializeField] private float maxExpectedValue = 50000f; // Scales max height safely

    private Texture2D generatedTexture;
    
    // Controlled dynamically by FilterManager toggle states
    private bool drawBarley = true;
    private bool drawSoldiers = false;

    private void Awake()
    {
        generatedTexture = new Texture2D(textureWidth, textureHeight, TextureFormat.RGBA32, false);
        generatedTexture.filterMode = FilterMode.Point; // Crisp mobile pixels
    }

    // Public API listener method called by FilterManager before running RenderData
    public void SetResourceToggles(bool barley, bool soldiers)
    {
        drawBarley = barley;
        drawSoldiers = soldiers;
    }

    // Fulfills the IDataVisualizer interface contract
    public void RenderData(List<DataRecord> filteredData)
    {
        if (filteredData == null || filteredData.Count == 0)
        {
            Clear();
            return;
        }

        GenerateGraphImage(filteredData);
    }

    private void GenerateGraphImage(List<DataRecord> records)
    {
        // 1. Clear background canvas
        Color[] backgroundPixels = new Color[textureWidth * textureHeight];
        for (int i = 0; i < backgroundPixels.Length; i++)
        {
            backgroundPixels[i] = backgroundColor; 
        }
        generatedTexture.SetPixels(backgroundPixels);

        int canvasWidth = textureWidth - (marginPadding * 2);
        int canvasHeight = textureHeight - (marginPadding * 2);

        // Fixed city layout configuration slots
        string[] citySlots = new string[] { "Akkad", "Ur", "Uruk" };
        int totalSlots = citySlots.Length;

        // Calculate maximum horizontal bounds available per city area group
        float groupWidthSpace = canvasWidth / (float)totalSlots;
        int groupGap = 10; // Spacing gap separating city clusters
        int activeGroupWidth = Mathf.FloorToInt(groupWidthSpace) - groupGap;

        // 2. Loop through our fixed structural city channels
        for (int i = 0; i < totalSlots; i++)
        {
            string currentSlotCity = citySlots[i];

            // Safely locate if this city record package exists in the current filtered stream
            DataRecord record = records.Find(r => r.city.Equals(currentSlotCity, System.StringComparison.OrdinalIgnoreCase));
            if (record == null) continue; // If filtered to red (turned off), skip drawing this city entirely

            // Calculate current base positioning anchor on the screen matrix line
            int baseGroupX = marginPadding + (i * Mathf.FloorToInt(groupWidthSpace)) + (groupGap / 2);

            // Determine how many sub-bars are drawing in this space group right now
            int metricsToDrawCount = 0;
            if (drawBarley) metricsToDrawCount++;
            if (drawSoldiers) metricsToDrawCount++;

            if (metricsToDrawCount == 0) continue; // If all metrics are toggled red, draw nothing

            int singleBarWidth = activeGroupWidth / metricsToDrawCount;
            int currentOffsetIndex = 0;

            // --- DRAW BARLEY BAR ---
            if (drawBarley)
            {
                float value = record.values.ContainsKey("CEBADA (GUR)") ? record.values["CEBADA (GUR)"] : 0f;
                int startX = baseGroupX + (currentOffsetIndex * singleBarWidth);
                int endX = startX + singleBarWidth - 2; // Subtract 2 for minor spacing buffer
                int endY = marginPadding + Mathf.FloorToInt(Mathf.Clamp01(value / maxExpectedValue) * canvasHeight);

                DrawFilledRectangle(startX, endX, marginPadding, endY, barleyColor);
                currentOffsetIndex++;
            }

            // --- DRAW SOLDIERS BAR ---
            if (drawSoldiers)
            {
                float value = record.values.ContainsKey("SOLDADOS") ? record.values["SOLDADOS"] : 0f;
                int startX = baseGroupX + (currentOffsetIndex * singleBarWidth);
                int endX = startX + singleBarWidth - 2;
                int endY = marginPadding + Mathf.FloorToInt(Mathf.Clamp01(value / maxExpectedValue) * canvasHeight);

                DrawFilledRectangle(startX, endX, marginPadding, endY, soldiersColor);
            }
        }

        // 3. Commit color tracking array changes straight to mobile graphics pipeline
        generatedTexture.Apply();

        // 4. Output texture into a responsive Sprite framework container element
        Sprite newSprite = Sprite.Create(generatedTexture, new Rect(0, 0, textureWidth, textureHeight), new Vector2(0.5f, 0.5f));
        if (uiImageDisplay != null)
        {
            uiImageDisplay.sprite = newSprite;
        }
    }

    private void DrawFilledRectangle(int xMin, int xMax, int yMin, int yMax, Color color)
    {
        for (int x = xMin; x < xMax; x++)
        {
            if (x < 0 || x >= textureWidth) continue;

            for (int y = yMin; y < yMax; y++)
            {
                if (y < 0 || y >= textureHeight) continue;

                generatedTexture.SetPixel(x, y, color);
            }
        }
    }

    public void Clear()
    {
        if (uiImageDisplay != null)
        {
            uiImageDisplay.sprite = null;
        }
    }
}
