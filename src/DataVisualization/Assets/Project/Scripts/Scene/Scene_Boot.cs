using UnityEngine;
using UnityEngine.SceneManagement;
using System.Collections;


public class Scene_Boot : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        SceneManager.LoadSceneAsync("Persistent", LoadSceneMode.Additive);
        StartCoroutine(LoadAndActivate(SceneList.Intro.ToString()));
    }


    private IEnumerator LoadAndActivate(string sceneName)
    {
        AsyncOperation op = SceneManager.LoadSceneAsync(sceneName, 
                              LoadSceneMode.Additive);
        
        // Wait for the load to finish
        while (!op.isDone)
        {
            yield return null;
        }

        // Small delay to ensure the scene is fully registered in the manager
        yield return null; 

        UnityEngine.SceneManagement.Scene loadedScene = SceneManager.GetSceneByName(sceneName);
        if (loadedScene.IsValid())
        {
            SceneManager.SetActiveScene(loadedScene);
        }

        ClearConsole();
    }

    void ClearConsole()
    {
        #if UNITY_EDITOR
            System.Type.GetType("UnityEditor.LogEntries, UnityEditor.dll").GetMethod("Clear").Invoke(null, null);
        #endif
    }
}