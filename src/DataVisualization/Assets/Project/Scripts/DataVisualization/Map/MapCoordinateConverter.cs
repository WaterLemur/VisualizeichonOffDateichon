using UnityEngine;

public class MapCoordinateConverter : MonoBehaviour
{
    [Header("Geographic Bounds")]
    [SerializeField] private float minLatitude;
    [SerializeField] private float maxLatitude;

    [SerializeField] private float minLongitude;
    [SerializeField] private float maxLongitude;

    [Header("Map")]
    [SerializeField] private RectTransform mapRect;

    public Vector3 Convert(
        float latitude,
        float longitude)
    {
        float x01 = Mathf.InverseLerp(
            minLongitude,
            maxLongitude,
            longitude
        );

        float y01 = Mathf.InverseLerp(
            minLatitude,
            maxLatitude,
            latitude
        );

        float x =
            Mathf.Lerp(
                mapRect.rect.xMin,
                mapRect.rect.xMax,
                x01
            );

        float y =
            Mathf.Lerp(
                mapRect.rect.yMin,
                mapRect.rect.yMax,
                y01
            );

        return new Vector3(x, y, 0f);
    }
}