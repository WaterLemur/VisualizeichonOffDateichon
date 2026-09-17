using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;


public interface IDataSource
{
    void LoadData(Action<DataSet> onComplete);
}

[Serializable]
public class DataPoint
{
    public string label;
    public float value;
}


[Serializable]
public class DataSet
{
    public string id;
    public string name;
    public string description;
    public Dimension dimension;
    public Records records;

    List<DataRecord> recordList;



    public List<DataPoint> points;
}

[Serializable]
public class DataRecord
{
    public int year;
    public string city;
    public Dictionary <string, float> values;
}

[Serializable]
public class Position
{
    public float latitude;
    public float longitude;
}

[Serializable]
public class DataValue
{

}

[Serializable]
public class DataManager : MonoBehaviour
{
    public IDataSource dataSource;
    public DataSet CurrentData { get; private set; }

    public void Load()
    {
        dataSource.LoadData(data =>
        {
            CurrentData = data;
        }); 
    }
}




[Serializable]
public class Dimension
{
    public string year;
    public string country;
    public string category;
}

[Serializable]
public class Records
{
    public string record;
}

[Serializable]
public class Record
{
    public int year;
    public string country;
    public string category;
    public string value;
}