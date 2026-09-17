using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using UnityEngine.UI;


public class BarChart3D : MonoBehaviour, IDataVisualization
{
    [SerializeField]
    private Image image;

    public void SetData(DataSet data)
    {
        // TODO: Select/update appropriate image
    }

    public void Refresh()
    {

    }
    public void Clear()
    {
        image.sprite = null;
    }
}
