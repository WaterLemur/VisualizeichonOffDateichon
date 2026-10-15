using UnityEngine;

public class MapCoordinateConverter : MonoBehaviour
{
    [Header("Geographic Bounds")]
    [SerializeField] private float minLatitude;
    [SerializeField] private float maxLatitude;

    [SerializeField] private float minLongitude;
    [SerializeField] private float maxLongitude;

    [Header("Coordinate Scale")]
    [SerializeField] private float coordinateScale = 1f;

    [Header("Map Offset")]
    [SerializeField] private float offsetX = 0f;
    [SerializeField] private float offsetY = 0f;

    public Vector2 Convert(float latitude, float longitude)
    {
        float centerLatitude =
            (minLatitude + maxLatitude) * 0.5f;

        float centerLongitude =
            (minLongitude + maxLongitude) * 0.5f;

        float x =
            (longitude - centerLongitude) *
            coordinateScale;

        float y =
            (latitude - centerLatitude) *
            coordinateScale;

        x += offsetX;
        y += offsetY;

        return new Vector2(x, y);
    }
}