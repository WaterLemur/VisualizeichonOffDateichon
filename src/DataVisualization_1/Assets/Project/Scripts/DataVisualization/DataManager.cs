using System;
using UnityEngine;


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