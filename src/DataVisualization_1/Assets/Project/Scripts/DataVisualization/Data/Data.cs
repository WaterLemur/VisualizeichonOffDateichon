using System;
using System.Collections.Generic;
using UnityEngine;


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
    public Position position;
    public string city;
    public Dictionary<string, float> values = new();
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




[Serializable]
public class CityPosition
{
    public string city;
    public float latitude;
    public float longitude;
}

[Serializable]
public class TimeDataRecord
{
    public int year;
    public string city;

    public Dictionary<string, float> values =
        new Dictionary<string, float>();
}