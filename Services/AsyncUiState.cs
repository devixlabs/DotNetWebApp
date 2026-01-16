namespace DotNetWebApp.Services;

public sealed class AsyncUiState
{
    private readonly Func<Task> _notify;

    public AsyncUiState(Func<Task> notify)
    {
        _notify = notify;
    }

    public bool IsBusy { get; private set; }

    public async Task RunAsync(Func<Task> action)
    {
        if (IsBusy)
        {
            return;
        }

        IsBusy = true;
        await _notify();

        try
        {
            await action();
        }
        finally
        {
            IsBusy = false;
            await _notify();
        }
    }
}
