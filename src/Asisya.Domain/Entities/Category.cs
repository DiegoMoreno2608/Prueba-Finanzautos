namespace Asisya.Domain.Entities;

public class Category
{
  public int Id { get; set; }
  public string Name { get; set; } = string.Empty;
  public string? PhotoUrl { get; set; }
  public ICollection<Product> Products { get; set; } = new List<Product>();
}
