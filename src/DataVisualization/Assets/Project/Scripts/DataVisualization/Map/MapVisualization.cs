using System.Collections.Generic;
using UnityEngine;

public class MapVisualization : MonoBehaviour
{
    [Header("Bubble")]
    [SerializeField] private DataBubble bubblePrefab;
    [SerializeField] private Transform bubbleParent;

    [Header("Map")]
    [SerializeField] private RectTransform mapRect;


    [SerializeField]
    private MapCoordinateConverter coordinateConverter;


    private readonly Dictionary<string, DataBubble> bubbles = new();

    public void CreateCityBubbles(
        IReadOnlyList<CityPosition> cities)
    {
        ClearBubbles();

        foreach (CityPosition city in cities)
        {
            DataBubble bubble =
                Instantiate(bubblePrefab, bubbleParent);

            Vector3 position =
                coordinateConverter.Convert(
                    city.latitude,
                    city.longitude
                );

            bubble.transform.localPosition = position;

            // No resource selected yet.
            bubble.SetCoordinates(
                city.latitude,
                city.longitude
            );

            bubbles.Add(city.city, bubble);
        }
    }

    private void ClearBubbles()
    {
        foreach (DataBubble bubble in bubbles.Values)
        {
            Destroy(bubble.gameObject);
        }

        bubbles.Clear();
    }
}