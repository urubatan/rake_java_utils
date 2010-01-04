package other;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Test;

public class OtherTest {
	private Other other;

	@Before
	public void setUp() throws Exception {
		this.other = new Other();
	}

	@Test
	public void sayHelo() {
		Assert.assertEquals("Hello World", other.sayHello("World"));
	}
}
