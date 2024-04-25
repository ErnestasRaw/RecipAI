public class ResponseWrapper<T>
{
	public T Data { get; set; }
	public bool Success { get; set; }

	public ResponseWrapper(T data, bool success = true)
	{
		Data = data;
		Success = success;
	}
}
