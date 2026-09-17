using System.Collections;

using UnityEngine;
using UnityEngine.SceneManagement;


public class ScenePersistent : MonoBehaviour
{
    [Header("References")]

    [Header("Variables")]


    public static ScenePersistent Instance { get; private set; }


    private void Awake()
    {
        if (Instance == null) Instance = this;
        else Destroy(gameObject);
    }

    void Start()
    {

    }

    // --------------------- Scene "manager" ------------------------
    public void Unload(SceneList scene)
    {
        string sceneName = scene.ToString();
        SceneManager.UnloadSceneAsync(sceneName);
    }
      public void Unload()
    {
        //Unload(Game.Instance.CurrentScene);
    }

    public void Activate(SceneList scene)
    {
        
    }
    public void LoadAndActivate(SceneList scene)
    {
        string sceneName = scene.ToString();
        StartCoroutine(LoadAndActivateRoutine(sceneName));
    }

    private IEnumerator LoadAndActivateRoutine(string sceneName)
    {
        AsyncOperation op = SceneManager.LoadSceneAsync(sceneName, LoadSceneMode.Additive);
        
        // Wait for the load to finish
        while (!op.isDone)
        {
            yield return null;
        }

        // Small delay to ensure the scene is fully registered in the manager
        yield return null; 
    }
}